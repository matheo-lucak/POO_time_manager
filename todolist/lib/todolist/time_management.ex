defmodule Todolist.TimeManagement do
  @moduledoc """
  The TimeManagement context.
  """

  import Ecto.Query, warn: false
  alias Todolist.Repo

  alias Todolist.TimeManagement.Clock

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Get a clock from user id
  Returns Clock
  """
  def get_user_clock(userId) do
    query = from(t in Clock, where: t.user_id == ^userId)
    Repo.one(query)
  end

  @doc """
  Create a clock linked to a user id
  Returns Created user clock
  """
  def create_user_clock(userId) do
    create_clock(%{
      status: false,
      time: DateTime.utc_now(),
      user_id: userId
    })
  end

  @doc """
  Returns Clock
  """
  def find_or_create_user_clock(userId) do
    found_clock = get_user_clock(userId)

    if !found_clock do
      create_user_clock(userId)
      get_user_clock(userId)
    else
      get_user_clock(userId)
    end
  end

  @doc """
  Returns Clock
  """
  def toggle_user_clock(userId) do
    clock = find_or_create_user_clock(userId)

    if clock.status == true do
      # Turn off the clock.
      # Create new WorkingTime
      create_working_time(%{
        end: DateTime.utc_now(),
        start: clock.time,
        user_id: userId
      })
      update_clock(clock, %{status: false})
    else
      # Turn on the clock
      update_clock(clock, %{status: true, time: DateTime.utc_now()})
    end
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}

  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  alias Todolist.TimeManagement.WorkingTime

  @doc """
  Returns the list of working_times.

  ## Examples

      iex> list_working_times()
      [%WorkingTime{}, ...]

  """
  def list_working_times() do
    Repo.all(WorkingTime)
  end

  @doc """
  Returns the list of working_times of a given user.
  """
  def list_working_times_by_user(userId) do
    query = from(t in WorkingTime, where: t.user_id == ^userId)
    Repo.all(query)
  end

  @doc """
  Gets a single working_time.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time!(123)
      %WorkingTime{}

      iex> get_working_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time(id) do
    query = from t in WorkingTime, where: t.id == ^id
    Repo.one(query)
  end

  def get_working_time_by_user(userId, id) do
    query = from t in WorkingTime, where: t.user_id == ^userId and t.id == ^id
    Repo.one(query)
  end


  @doc """
  Creates a working_time.

  ## Examples

      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}

      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a working_time.

  ## Examples

      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}

      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_time.

  ## Examples

      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}

      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.

  ## Examples

      iex> change_working_time(working_time)
      %Ecto.Changeset{data: %WorkingTime{}}

  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end
end
