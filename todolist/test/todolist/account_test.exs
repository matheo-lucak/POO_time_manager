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

    @invalid_attrs %{email: nil, username: nil, password: nil, password_confirmation: nil}

    @invalid_email_attrs %{
      email: "bad email",
      username: "valid username",
      password: "password",
      password_confirmation: "password"
    }

    test "list_users/0 no users" do
      assert Account.list_users() == []
    end

    test "list_users/1 one user" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "list_users/2 returns multiple users" do
      users = [
        user_fixture(%{username: "A", email: "A@A.fr"}),
        user_fixture(%{username: "B", email: "B@B.fr"}),
        user_fixture(%{username: "C", email: "C@C.fr"})
      ]

      assert Account.list_users() == users
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        email: "valid@email.fr",
        username: "some username",
        password: "password",
        password_confirmation: "password"
      }

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

      update_attrs = %{
        email: "updated@email.fr",
        username: "some updated username",
        current_password: "super secure password"
      }

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

  # describe "teams" do
  #   alias Todolist.Account.Team

  #   import Todolist.AccountFixtures

  #   @invalid_attrs %{}

  #   test "list_teams/0 returns all teams" do
  #     team = team_fixture()
  #     assert Account.list_teams() == [team]
  #   end

  #   test "get_team!/1 returns the team with given id" do
  #     team = team_fixture()
  #     assert Account.get_team!(team.id) == team
  #   end

  #   test "create_team/1 with valid data creates a team" do
  #     valid_attrs = %{}

  #     assert {:ok, %Team{} = team} = Account.create_team(valid_attrs)
  #   end

  #   test "create_team/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Account.create_team(@invalid_attrs)
  #   end

  #   test "update_team/2 with valid data updates the team" do
  #     team = team_fixture()
  #     update_attrs = %{}

  #     assert {:ok, %Team{} = team} = Account.update_team(team, update_attrs)
  #   end

  #   test "update_team/2 with invalid data returns error changeset" do
  #     team = team_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Account.update_team(team, @invalid_attrs)
  #     assert team == Account.get_team!(team.id)
  #   end

  #   test "delete_team/1 deletes the team" do
  #     team = team_fixture()
  #     assert {:ok, %Team{}} = Account.delete_team(team)
  #     assert_raise Ecto.NoResultsError, fn -> Account.get_team!(team.id) end
  #   end

  #   test "change_team/1 returns a team changeset" do
  #     team = team_fixture()
  #     assert %Ecto.Changeset{} = Account.change_team(team)
  #   end
  # end
end
