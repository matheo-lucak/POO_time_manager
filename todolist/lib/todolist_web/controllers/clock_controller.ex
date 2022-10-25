defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller

  alias Todolist.TimeManagement
  alias Todolist.TimeManagement.Clock

  action_fallback(TodolistWeb.FallbackController)

  def index(conn, %{"userID" => userId}) do
    clock = TimeManagement.get_user_clock(userId)
    render(conn, "show.json", clock: clock)
  end

  def toggle(conn, %{"userID" => userId}) do
    with {:ok, %Clock{} = clock} <- TimeManagement.toggle_user_clock(userId) do
      render(conn, "show.json", clock: clock)
    end
  end
end
