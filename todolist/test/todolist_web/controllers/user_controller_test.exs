defmodule TodolistWeb.UserControllerTest do
  use TodolistWeb.ConnCase

  import Todolist.AccountFixtures
  alias Todolist.TestUtils
  alias Todolist.Account.User

  @create_attrs %{
    email: "some@email.fr",
    username: "some username"
  }
  @update_attrs %{
    email: "some@updated.email",
    username: "some updated username"
  }
  @invalid_email_attrs %{
    email: "invalid email",
    username: "valid username"
  }
  @invalid_attrs %{email: nil, username: nil}

  setup %{conn: conn} do
    TestUtils.delete_all()
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users. No users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists all users. Multiple users", %{conn: conn} do
      users = [user_fixture(), user_fixture(), user_fixture()]
      formatted_users = users |> Enum.map(&user_to_map/1)

      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == formatted_users
    end

    test "lists all users. Filter email. No match", %{
      conn: conn
    } do
      %{
        unique_user: unique_user,
        dup_username_user: dup_username_user,
        dup_email_user: dup_email_user
      } = create_different_users(%{})

      # assert true
      conn = get(conn, Routes.user_path(conn, :index, email: "unmatched@email.fr"))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists all users. Filter email", %{
      conn: conn
    } do
      %{
        unique_user: unique_user,
        dup_username_user: dup_username_user,
        dup_email_user: dup_email_user
      } = create_different_users(%{})

      conn = get(conn, Routes.user_path(conn, :index, email: "unmatched@email.fr"))
      assert json_response(conn, 200)["data"] == []

      conn = get(conn, Routes.user_path(conn, :index, email: "unique@email.fr"))
      assert json_response(conn, 200)["data"] == unique_user |> Enum.map(&user_to_map/1)

      conn = get(conn, Routes.user_path(conn, :index, email: "dup@email.fr"))
      assert json_response(conn, 200)["data"] == dup_email_user |> Enum.map(&user_to_map/1)
    end

    test "lists all users. Filter username", %{
      conn: conn
    } do
      %{
        unique_user: unique_user,
        dup_username_user: dup_username_user,
        dup_email_user: dup_email_user
      } = create_different_users(%{})

      conn = get(conn, Routes.user_path(conn, :index, username: "unmatched username"))
      assert json_response(conn, 200)["data"] == []

      conn = get(conn, Routes.user_path(conn, :index, username: "unique username"))
      assert json_response(conn, 200)["data"] == unique_user |> Enum.map(&user_to_map/1)

      conn = get(conn, Routes.user_path(conn, :index, username: "dup username"))
      assert json_response(conn, 200)["data"] == dup_username_user |> Enum.map(&user_to_map/1)
    end

    test "lists all users. Filter username and email", %{
      conn: conn
    } do
      %{
        unique_user: unique_user,
        dup_username_user: dup_username_user,
        dup_email_user: dup_email_user,
        dup_user: dup_user
      } = create_different_users(%{})

      conn = get(conn, Routes.user_path(conn, :index, username: "unmatched username", email: "unmatched@email.fr"))
      assert json_response(conn, 200)["data"] == []

      conn = get(conn, Routes.user_path(conn, :index, username: "unique username", email: "unmatched@email.fr"))
      assert json_response(conn, 200)["data"] == []

      conn = get(conn, Routes.user_path(conn, :index, username: "unmatched username", email: "unique@email.fr"))
      assert json_response(conn, 200)["data"] == []

      conn = get(conn, Routes.user_path(conn, :index, username: "unique username", email: "unique@email.fr"))
      assert json_response(conn, 200)["data"] == unique_user |> Enum.map(&user_to_map/1)

      conn = get(conn, Routes.user_path(conn, :index, username: "clone username", email: "clone@email.fr"))
      assert json_response(conn, 200)["data"] == dup_user |> Enum.map(&user_to_map/1)
    end

  end

  describe "show" do
    test "Show existing user", %{conn: conn} do
      user = user_fixture()
      conn = get(conn, Routes.user_path(conn, :show, user.id))

      assert json_response(conn, 200)["data"] == user_to_map(user)
    end

    test "No user exist", %{conn: conn} do
      user = user_fixture()
      conn = get(conn, Routes.user_path(conn, :show, 1))
      assert json_response(conn, 200)["data"] == nil
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some@email.fr",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when email is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_email_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some@updated.email",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      # assert_error_sent 404, fn ->
      #   get(conn, Routes.user_path(conn, :show, user))
      # end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  defp create_different_users(_) do
    unique_user = [user_fixture(%{email: "unique@email.fr", username: "unique username"})]

    dup_username_user = [
      user_fixture(%{email: "AAAA@email.fr", username: "dup username"}),
      user_fixture(%{email: "BBBB@email.fr", username: "dup username"})
    ]

    dup_email_user = [
      user_fixture(%{email: "dup@email.fr", username: "AAAA"}),
      user_fixture(%{email: "dup@email.fr", username: "BBBB"})
    ]

    dup_user = [
      user_fixture(%{email: "clone@email.fr", username: "clone username"}),
      user_fixture(%{email: "clone@email.fr", username: "clone username"})
    ]

    %{
      unique_user: unique_user,
      dup_username_user: dup_username_user,
      dup_email_user: dup_email_user,
      dup_user: dup_user,
    }
  end

  def user_to_map(user) do
    %{
      "id" => user.id,
      "email" => user.email,
      "username" => user.username
    }
  end
end
