defmodule TodolistWeb.WorkingTimeController do
  use TodolistWeb, :controller
  require Logger
  alias Todolist.TimeManagement
  alias Todolist.TimeManagement.WorkingTime
  alias Todolist.Account

  action_fallback(TodolistWeb.FallbackController)

  def index(conn, %{"userID" => userID} = params) do
    Account.verify_user!(userID)

    working_times = TimeManagement.list_working_times_by_user(userID, params)
    render(conn, "index.json", working_times: working_times)
  end

  def create(conn, %{"userID" => userID, "working_time" => working_time_params}) do
    Account.verify_user!(userID)

    working_time_params = Map.put(working_time_params, "user_id", userID)

    with {:ok, %WorkingTime{} = working_time} <-
           TimeManagement.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, userID, working_time.id))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, %{"userID" => userID, "id" => id}) do
    Account.verify_user!(userID)

    working_time = TimeManagement.get_working_time_by_user(userID, id)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"userID" => _, "id" => id, "working_time" => working_time_params}) do
    working_time = TimeManagement.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <-
           TimeManagement.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"userID" => _, "id" => id}) do
    working_time = TimeManagement.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- TimeManagement.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
