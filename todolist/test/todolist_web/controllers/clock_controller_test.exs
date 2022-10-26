defmodule TodolistWeb.ClockControllerTest do
  use TodolistWeb.ConnCase
  alias Todolist.TestUtils

  import Todolist.TimeManagementFixtures
  import Todolist.AccountFixtures
  alias Todolist.TimeManagement
  alias Todolist.TimeManagement.Clock

  setup %{conn: conn} do
    TestUtils.delete_all()
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "List user clock. User has no clock", %{conn: conn} do
      user = user_fixture()

      conn = get(conn, Routes.clock_path(conn, :index, user.id))
      assert json_response(conn, 200)["data"] == nil
    end

    test "List user clock. User has clock", %{conn: conn} do
      user = user_fixture()
      {:ok, clock} = TimeManagement.create_user_clock(user.id)

      conn = get(conn, Routes.clock_path(conn, :index, user.id))
      json_clock = assert json_response(conn, 200)["data"]

      assert json_clock == %{
               "id" => clock.id,
               "status" => clock.status,
               "time" => DateTime.to_iso8601(clock.time)
             }
    end
  end

  describe "Toggle clock" do
    test "Toggle user clock once", %{conn: conn} do
      user = user_fixture()

      conn = post(conn, Routes.clock_path(conn, :toggle, user.id))
      json_clock = assert json_response(conn, 200)["data"]
      clock = TimeManagement.get_user_clock(user.id)

      assert json_clock == %{
               "id" => clock.id,
               "status" => clock.status,
               "time" => DateTime.to_iso8601(clock.time)
             }
    end

    test "Toggle user clock many times", %{conn: conn} do
      user = user_fixture()

      Enum.each(0..99, fn i ->
        conn = post(conn, Routes.clock_path(conn, :toggle, user.id))
        json_clock = assert json_response(conn, 200)["data"]
        clock = TimeManagement.get_user_clock(user.id)

        # Just to be sure clock has been toggled
        if rem(i, 2) == 0 do
          assert clock.status == true
        else
          assert clock.status == false
        end

        assert json_clock == %{
                 "id" => clock.id,
                 "status" => clock.status,
                 "time" => DateTime.to_iso8601(clock.time)
               }
      end)
    end
  end
end
