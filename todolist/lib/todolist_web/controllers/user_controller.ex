defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller
  require Logger

  alias Todolist.Account
  alias Todolist.Account.User
  alias Todolist.Repo
  import Ecto.Query

  action_fallback TodolistWeb.FallbackController

  def index(conn, %{"username" => username, "email" => email}) do
    query = from t in User, where: t.username == ^username and t.email == ^email, select: t, limit: 1
    user = Repo.one(query)
    render(conn, "show.json", user: user)
  end

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user(id)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user(id)

    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
