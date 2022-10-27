defmodule TodolistWeb.WorkingTimeControllerTest do
  use TodolistWeb.ConnCase

  import Todolist.TimeManagementFixtures
  import Todolist.AccountFixtures

  alias Todolist.TimeManagement.WorkingTime
  alias Todolist.TestUtils

  @create_attrs %{
    end: ~U[2022-10-24 09:38:00Z],
    start: ~U[2022-10-24 09:38:00Z]
  }
  @update_attrs %{
    end: ~U[2022-10-25 09:38:00Z],
    start: ~U[2022-10-25 09:38:00Z]
  }
  @invalid_attrs %{end: nil, start: nil}

  setup %{conn: conn} do
    TestUtils.delete_all()
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all working_times. No working times", %{conn: conn} do
      user = user_fixture()
      conn = get(conn, Routes.working_time_path(conn, :index, user.id))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists all working_times. Few working times", %{conn: conn} do
      user = user_fixture()

      working_times = [
        working_time_fixture(%{user_id: user.id}),
        working_time_fixture(%{user_id: user.id}),
        working_time_fixture(%{user_id: user.id})
      ]

      formatted_working_times =
        Enum.map(working_times, fn w ->
          %{
            "id" => w.id,
            "user_id" => user.id,
            "start" => DateTime.to_iso8601(w.start),
            "end" => DateTime.to_iso8601(w.end)
          }
        end)

      conn = get(conn, Routes.working_time_path(conn, :index, user.id))
      assert json_response(conn, 200)["data"] == formatted_working_times
    end
  end

  describe "show" do
    test "Show one user working time", %{conn: conn} do
      user = user_fixture()
      wt = working_time_fixture(%{user_id: user.id})
      conn = get(conn, Routes.working_time_path(conn, :show, user.id, wt.id))

      assert json_response(conn, 200)["data"] == %{
               "id" => wt.id,
               "user_id" => user.id,
               "start" => DateTime.to_iso8601(wt.start),
               "end" => DateTime.to_iso8601(wt.end)
             }
    end

    test "Show one user working time. Unknown working time", %{conn: conn} do
      user = user_fixture()
      wt = working_time_fixture(%{user_id: user.id})
      conn = get(conn, Routes.working_time_path(conn, :show, user.id, wt.id + 1))
      assert json_response(conn, 200)["data"] == nil
    end
  end

  describe "create working_time" do
    test "renders working_time when data is valid", %{conn: conn} do
      user = user_fixture()

      conn =
        post(conn, Routes.working_time_path(conn, :create, user.id), working_time: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.working_time_path(conn, :show, user.id, id))

      assert %{
               "id" => ^id,
               "end" => "2022-10-24T09:38:00Z",
               "start" => "2022-10-24T09:38:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      conn =
        post(conn, Routes.working_time_path(conn, :create, user.id), working_time: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update working_time" do
    setup [:create_user_and_working_time]

    test "renders working_time when data is valid", %{
      conn: conn,
      working_time: %WorkingTime{id: id} = working_time,
      user: user
    } do
      conn =
        put(conn, Routes.working_time_path(conn, :update, working_time),
          working_time: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.working_time_path(conn, :show, user.id, working_time))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "end" => "2022-10-25T09:38:00Z",
               "start" => "2022-10-25T09:38:00Z",
               "user_id" => user.id
             }
    end

    test "renders errors when data is invalid", %{conn: conn, working_time: working_time} do
      conn =
        put(conn, Routes.working_time_path(conn, :update, working_time),
          working_time: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete working_time" do
    setup [:create_user_and_working_time]

    test "deletes chosen working_time", %{conn: conn, working_time: working_time, user: user} do
      conn = delete(conn, Routes.working_time_path(conn, :delete, working_time))
      assert response(conn, 204)

      conn = get(conn, Routes.working_time_path(conn, :show, user.id, working_time.id))
      assert json_response(conn, 200)["data"] == nil
    end
  end

  defp create_user_and_working_time(_) do
    user = user_fixture()
    working_time = working_time_fixture(%{user_id: user.id})
    %{user: user, working_time: working_time}
  end
end
