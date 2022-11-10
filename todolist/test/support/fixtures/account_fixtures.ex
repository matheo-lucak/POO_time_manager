defmodule Todolist.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some@email.fr",
        username: "some username",
        password: "super secure password",
        password_confirmation: "super secure password"
      })
      |> Todolist.Account.create_user()

    user
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{

      })
      |> Todolist.Account.create_team()

    team
  end
end
