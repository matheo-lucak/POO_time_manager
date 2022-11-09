defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller
  require Logger

  alias Todolist.Account
  alias Todolist.Account.User

  action_fallback(TodolistWeb.FallbackController)

  def index(conn, params) do
    users = Account.list_users(params)

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

  def show(conn, %{"userID" => userID}) do
    user = Account.get_user(userID)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"userID" => userID, "user" => user_params}) do
    user = Account.get_user(userID)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => userID}) do
    user = Account.get_user(userID)

    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def promote(conn, %{"userID" => userID}) do
    user = Account.verify_user!(userID)

    if user.role == "user" do
      Account.unsafe_update_user(user, %{role: "manager"})
      user = Account.get_user(user.id)

      conn
      |> render("show.json", user: user)
    else
      conn
      |> send_resp(:not_modified, "")
    end
  end

  def demote(conn, %{"userID" => userID}) do
    user = Account.verify_user!(userID)

    if user.role == "manager" do
      Account.unsafe_update_user(user, %{role: "user"})
      user = Account.get_user(user.id)

      conn
      |> render("show.json", user: user)
    else
      conn
      |> send_resp(:not_modified, "")
    end
  end
end
