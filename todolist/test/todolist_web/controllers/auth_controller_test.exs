defmodule TodolistWeb.AuthControllerTest do
  use TodolistWeb.ConnCase

  import Todolist.AccountFixtures
  alias Todolist.TestUtils
  alias Todolist.Auth.Token

  setup %{conn: conn} do
    TestUtils.delete_all()
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "Register" do
    test "Register new user", %{conn: conn} do
      IO.inspect(TodolistWeb.Router.Helpers)

      reg_attr = %{
        email: "some@email.fr",
        username: "some username",
        password: "super secure password",
        password_confirmation: "super secure password"
      }

      # user_login_path
      conn = post(conn, Routes.user_registration_path(conn, :register), reg_attr)
      token = json_response(conn, 200)["token"]
      {:ok, claim} = Token.verify_and_validate(token)
      assert claim["user_id"] != nil
    end

    test "Register twice a user", %{conn: conn} do
      IO.inspect(TodolistWeb.Router.Helpers)

      reg_attr = %{
        email: "some@email.fr",
        username: "some username",
        password: "super secure password",
        password_confirmation: "super secure password"
      }

      conn = post(conn, Routes.user_registration_path(conn, :register), reg_attr)
      assert json_response(conn, 200)["token"] != nil

      conn = post(conn, Routes.user_registration_path(conn, :register), reg_attr)
      assert json_response(conn, 500)["error"] != nil
    end
  end

  describe "Login" do
    test "Simple login", %{conn: conn} do
      IO.inspect(TodolistWeb.Router.Helpers)

      reg_attr = %{
        email: "some@email.fr",
        username: "some username",
        password: "super secure password",
        password_confirmation: "super secure password"
      }

      user = user_fixture(reg_attr)

      conn = post(conn, Routes.user_login_path(conn, :login), reg_attr)
      token = json_response(conn, 200)["token"]
      {:ok, claim} = Token.verify_and_validate(token)
      assert claim["user_id"] == user.id
    end
  end
end
