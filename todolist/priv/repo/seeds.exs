# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Todolist.Repo.insert!(%Todolist.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Todolist.Account

Account.create_user(%{
  email: "general_manager_1@epitech.eu",
  username: "General Manager 1",
  password: "general manager password",
  password_confirmation: "general manager password",
  role: "general_manager"
})

Account.create_user(%{
  email: "manager_1@epitech.eu",
  username: "Manager 1",
  password: "manager password",
  password_confirmation: "manager password",
  role: "manager"
})

Account.create_user(%{
  email: "user_1@epitech.eu",
  username: "User 1",
  password: "user password",
  password_confirmation: "user password",
  role: "user"
})
