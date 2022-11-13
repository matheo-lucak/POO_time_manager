defmodule Todolist.TimeManagement.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolist.TimeManagement

  schema "working_times" do
    field(:end, :utc_datetime)
    field(:start, :utc_datetime)
    field(:user_id, :id)

    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
    |> validate_positive_duration
    |> validate_maximum_duration
    |> validate_overlapping
  end

  defp validate_positive_duration(changeset) do
    time_start = changeset.changes.start
    time_end = changeset.changes.end

    if time_start >= time_end do
      add_error(changeset, :end, "A working time must start before it ends")
    else
      changeset
    end
  end

  defp validate_maximum_duration(changeset) do
    time_start = changeset.changes.start
    time_end = changeset.changes.end

    if Date.diff(time_start, time_end) != 0 do
      add_error(changeset, :end, "A working time must not extend over the following days")
    else
      changeset
    end
  end

  defp validate_overlapping(changeset) do
    time_start = changeset.changes.start
    time_end = changeset.changes.end
    user_id = changeset.changes.user_id

    overlap_matches =
      TimeManagement.list_overlapping_working_times_by_user(user_id, time_start, time_end)

    if overlap_matches != [] do
      add_error(changeset, :end, "A Working time must not overlap any other")
    else
      changeset
    end
  end
end
