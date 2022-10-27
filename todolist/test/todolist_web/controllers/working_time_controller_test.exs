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

      formatted_working_times = working_times_to_maps(working_times, user.id)

      conn = get(conn, Routes.working_time_path(conn, :index, user.id))
      assert json_response(conn, 200)["data"] == formatted_working_times
    end

    test "lists all working_times. Filter by start", %{conn: conn} do
      user = user_fixture()

      working_times = [
        working_time_fixture(%{user_id: user.id, start: ~U[2000-10-10 00:00:00Z]}),
        working_time_fixture(%{user_id: user.id, start: ~U[2001-10-10 00:00:00Z]}),
        working_time_fixture(%{user_id: user.id, start: ~U[2002-10-10 00:00:00Z]})
      ]

      formatted_working_times = working_times_to_maps(working_times, user.id)

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, start: "1999-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == formatted_working_times

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, start: "2000-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == formatted_working_times

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, start: "2001-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == [
               Enum.at(formatted_working_times, 1),
               Enum.at(formatted_working_times, 2)
             ]

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, start: "2002-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == [
               Enum.at(formatted_working_times, 2)
             ]

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, start: "2003-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == []
    end

    test "lists all working_times. Filter by end", %{conn: conn} do
      user = user_fixture()

      working_times = [
        working_time_fixture(%{user_id: user.id, end: ~U[2000-10-10 00:00:00Z]}),
        working_time_fixture(%{user_id: user.id, end: ~U[2001-10-10 00:00:00Z]}),
        working_time_fixture(%{user_id: user.id, end: ~U[2002-10-10 00:00:00Z]})
      ]

      formatted_working_times = working_times_to_maps(working_times, user.id)

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, end: "1999-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == []

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, end: "2000-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == [
               Enum.at(formatted_working_times, 0)
             ]

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, end: "2001-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == [
               Enum.at(formatted_working_times, 0),
               Enum.at(formatted_working_times, 1)
             ]

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, end: "2002-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == formatted_working_times

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id, end: "2003-10-10T00:00:00Z")
        )

      assert json_response(conn, 200)["data"] == formatted_working_times
    end

    test "lists all working_times. Filter by start and end", %{conn: conn} do
      user = user_fixture()

      working_times = [
        working_time_fixture(%{
          user_id: user.id,
          start: ~U[2000-10-10 00:00:00Z],
          end: ~U[2001-10-10 00:00:00Z]
        }),
        working_time_fixture(%{
          user_id: user.id,
          start: ~U[2002-10-10 00:00:00Z],
          end: ~U[2003-10-10 00:00:00Z]
        })
      ]

      formatted_working_times = working_times_to_maps(working_times, user.id)

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id,
            start: "1999-10-10T00:00:00Z",
            end: "2004-10-10T00:00:00Z"
          )
        )

      assert json_response(conn, 200)["data"] == formatted_working_times

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id,
            start: "1999-10-10T00:00:00Z",
            end: "2001-10-10T00:00:00Z"
          )
        )

      assert json_response(conn, 200)["data"] == [Enum.at(formatted_working_times, 0)]

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id,
            start: "2002-10-10T00:00:00Z",
            end: "2004-10-10T00:00:00Z"
          )
        )

      assert json_response(conn, 200)["data"] == [Enum.at(formatted_working_times, 1)]

      conn =
        get(
          conn,
          Routes.working_time_path(conn, :index, user.id,
            start: "2050-10-10T00:00:00Z",
            end: "2055-10-10T00:00:00Z"
          )
        )

      assert json_response(conn, 200)["data"] == []
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

  defp working_times_to_maps(working_times, user_id) do
    Enum.map(working_times, fn w ->
      %{
        "id" => w.id,
        "user_id" => user_id,
        "start" => DateTime.to_iso8601(w.start),
        "end" => DateTime.to_iso8601(w.end)
      }
    end)
  end
end
