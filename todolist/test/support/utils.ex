defmodule Todolist.TestUtils do
  alias Todolist.Repo

  alias Todolist.TimeManagement.Clock
  alias Todolist.TimeManagement.WorkingTime
  alias Todolist.Account.User

  def delete_all() do
    delete_all_users()
    delete_all_clocks()
    delete_all_working_times()
  end

  def delete_all_users() do
    Repo.delete_all(User)
  end

  def delete_all_clocks() do
    Repo.delete_all(Clock)
  end

  def delete_all_working_times() do
    Repo.delete_all(WorkingTime)
  end
end
