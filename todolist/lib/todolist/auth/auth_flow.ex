defmodule Todolist.Auth.AuthFlow do
  use Pow.Plug.Base

  require Logger

  alias Plug.Conn
  alias Todolist.Auth.Token
  alias Todolist.Account

  @impl true
  def fetch(conn, _config) do
    with {:ok, jwt_token} <- read_token(conn),
         {:ok, claims} <- validate_token(jwt_token) do
      user_id = claims["user_id"]
      user = Account.get_user!(user_id)

      conn =
        conn
        |> Conn.put_private(:api_access_token, jwt_token)
        |> Conn.put_private(:user_id, user_id)
        |> Conn.put_private(:current_user, user)

      {conn, %{"token" => jwt_token}}
    else
      _any -> {conn, nil}
    end
  end

  @impl true
  def create(conn, user, _config) do
    claims = %{"user_id" => user.id}
    generated_token = Token.generate_and_sign!(claims)
    user = Account.get_user!(user.id)

    conn =
      conn
      |> Conn.put_private(:api_access_token, generated_token)
      |> Conn.put_private(:current_user, user)

    {conn, user}
  end

  @impl true
  def delete(conn, _config) do
    conn
  end

  @spec read_token(Conn.t()) :: {atom(), any()}
  defp read_token(conn) do
    case Conn.get_req_header(conn, "authorization") do
      [token | _rest] -> {:ok, token |> String.replace("Bearer", "") |> String.trim()}
      _any -> {:error, "No Auth token found"}
    end
  end

  @spec validate_token(binary()) :: {atom(), any()}
  defp validate_token(jwt_token),
    do: Token.verify_and_validate(jwt_token)
end
