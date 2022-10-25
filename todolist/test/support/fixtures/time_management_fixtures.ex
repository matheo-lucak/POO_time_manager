defmodule Todolist.TimeManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.TimeManagement` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 09:38:00Z]
      })
      |> Todolist.TimeManagement.create_clock()

    clock
  end

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~U[2022-10-24 09:38:00Z],
        start: ~U[2022-10-24 09:38:00Z]
      })
      |> Todolist.TimeManagement.create_working_time()

    working_time
  end
end
