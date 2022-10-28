defmodule TodolistWeb.ClockControllerTest do
  use TodolistWeb.ConnCase

  import Todolist.TimeManagementFixtures
  import Todolist.AccountFixtures
  alias Todolist.TestUtils
  alias Todolist.TimeManagement
  alias Todolist.TimeManagement.Clock
  alias Todolist.Account

  setup %{conn: conn} do
    TestUtils.delete_all()
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_user]

    test "List user clock. User has no clock", %{conn: conn, user: user} do
      conn = get(conn, Routes.clock_path(conn, :index, user.id))
      assert json_response(conn, 200)["data"] == nil
    end

    test "List user clock. User has clock", %{conn: conn, user: user} do
      {:ok, clock} = TimeManagement.create_user_clock(user.id)

      conn = get(conn, Routes.clock_path(conn, :index, user.id))
      json_clock = assert json_response(conn, 200)["data"]

      assert json_clock == %{
               "id" => clock.id,
               "status" => clock.status,
               "time" => DateTime.to_iso8601(clock.time)
             }
    end

    test "List user clock of unknown user", %{conn: conn} do
      user = user_fixture()

      assert_raise Account.UserNotFoundError, fn ->
        get(conn, Routes.clock_path(conn, :index, user.id + 1))
      end
    end
  end

  describe "Toggle clock" do
    setup [:create_user]

    test "Toggle user clock once", %{conn: conn, user: user} do
      conn = post(conn, Routes.clock_path(conn, :toggle, user.id))
      json_clock = assert json_response(conn, 200)["data"]
      clock = TimeManagement.get_user_clock(user.id)

      assert json_clock == %{
               "id" => clock.id,
               "status" => clock.status,
               "time" => DateTime.to_iso8601(clock.time)
             }
    end

    test "Toggle user clock many times", %{conn: conn, user: user} do
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

    test "Toggle user clock of unknown user", %{conn: conn} do
      user = user_fixture()

      assert_raise Account.UserNotFoundError, fn ->
        post(conn, Routes.clock_path(conn, :toggle, user.id + 1))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
