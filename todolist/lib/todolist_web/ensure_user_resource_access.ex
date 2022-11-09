defmodule TodolistWeb.EnsureUserResourceAccess do
  @moduledoc """
  This plug ensures that a user either is a general_manager with all access, or a owner of accessed resources
  The user must first be authenticated.

  ## Example
      plug TodolistWeb.EnsureUserResourceAccess
  """
  import Plug.Conn, only: [halt: 1]

  alias TodolistWeb.Router.Helpers, as: Routes
  alias Phoenix.Controller
  alias Plug.Conn
  alias Pow.Plug
  use TodolistWeb, :controller

  alias Todolist.Account

  @doc false
  @spec init(any()) :: any()
  def init(config), do: config

  @doc false
  @spec call(Conn.t(), any()) :: Conn.t()
  def call(conn, _) do
    current_user = conn.private[:current_user]
    userID_query = conn.params["userID"]

    cond do
      userID_query == nil -> conn
      Account.is_general_manager(current_user) -> conn
      current_user.id == String.to_integer(userID_query) -> conn
      true -> access_error(conn)
    end
  end

  defp access_error(conn) do
    conn
    |> put_status(403)
    |> json(%{error: %{code: 403, message: "The user doesn't own this resource"}})
    |> halt()
  end
end
