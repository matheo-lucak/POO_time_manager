defmodule Todolist.AccountTest do
  use Todolist.DataCase

  alias Todolist.Account
  alias Todolist.TestUtils

  setup do
    TestUtils.delete_all()
    :ok
  end

  describe "users" do
    alias Todolist.Account.User

    import Todolist.AccountFixtures

    @invalid_attrs %{email: nil, username: nil}

    @invalid_email_attrs %{email: "bad email", username: "valid username"}

    test "list_users/0 no users" do
      assert Account.list_users() == []
    end

    test "list_users/1 one user" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "list_users/2 returns multiple users" do
      users = [user_fixture(), user_fixture(), user_fixture()]
      assert Account.list_users() == users
    end


    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "valid@email.fr", username: "some username"}

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.email == "valid@email.fr"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "create_user/1 with invalid email returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_email_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "updated@email.fr", username: "some updated username"}

      assert {:ok, %User{} = user} = Account.update_user(user, update_attrs)
      assert user.email == "updated@email.fr"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert Account.get_user(user.id) == nil
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
