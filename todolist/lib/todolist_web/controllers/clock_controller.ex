defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller

  alias Todolist.TimeManagement
  alias Todolist.TimeManagement.Clock
  alias Todolist.Account

  action_fallback(TodolistWeb.FallbackController)

  def index(conn, %{"userID" => userID}) do
    Account.verify_user!(userID)

    clock = TimeManagement.get_user_clock(userID)
    render(conn, "show.json", clock: clock)
  end

  def toggle(conn, %{"userID" => userID}) do
    Account.verify_user!(userID)

    with {:ok, %Clock{} = clock} <- TimeManagement.toggle_user_clock(userID) do
      render(conn, "show.json", clock: clock)
    end
  end
end
