defmodule Todolist.TimeManagementTest do
  use Todolist.DataCase

  alias Todolist.TimeManagement
  alias Todolist.TestUtils

  setup do
    TestUtils.delete_all()
    :ok
  end

  describe "clocks" do
    alias Todolist.TimeManagement.Clock

    import Todolist.AccountFixtures
    import Todolist.TimeManagementFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 no clock" do
      assert TimeManagement.list_clocks() == []
    end

    test "list_clocks/0 one clock" do
      user = user_fixture()
      clock = clock_fixture(%{user_id: user.id})
      assert TimeManagement.list_clocks() == [clock]
    end

    test "list_clocks/0 multiple clocks" do
      clocks = [
        clock_fixture(%{user_id: user_fixture().id}),
        clock_fixture(%{user_id: user_fixture().id}),
        clock_fixture(%{user_id: user_fixture().id})
      ]

      assert TimeManagement.list_clocks() == clocks
    end

    test "get_clock!/1 returns the clock with given id" do
      user = user_fixture()
      clock = clock_fixture(%{user_id: user.id})
      assert TimeManagement.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      user = user_fixture()
      valid_attrs = %{status: true, time: ~U[2022-10-24 09:38:00Z], user_id: user.id}

      assert {:ok, %Clock{} = clock} = TimeManagement.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-24 09:38:00Z]
      assert clock.user_id == user.id
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagement.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      user = user_fixture()
      clock = clock_fixture(%{user_id: user.id})
      update_attrs = %{status: false, time: ~U[2022-10-25 09:38:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManagement.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-25 09:38:00Z]
      assert clock.user_id == user.id
    end

    test "update_clock/2 with invalid data returns error changeset" do
      user = user_fixture()
      clock = clock_fixture(%{user_id: user.id})
      assert {:error, %Ecto.Changeset{}} = TimeManagement.update_clock(clock, @invalid_attrs)
      assert clock == TimeManagement.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      user = user_fixture()
      clock = clock_fixture(%{user_id: user.id})

      assert {:ok, %Clock{}} = TimeManagement.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManagement.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      user = user_fixture()
      clock = clock_fixture(%{user_id: user.id})

      assert %Ecto.Changeset{} = TimeManagement.change_clock(clock)
    end

    test "get_user_clock/1 User has no clock" do
      user = user_fixture()
      clock = TimeManagement.get_user_clock(user.id)

      assert clock == nil
    end

    test "get_user_clock/1 User has clock" do
      user = user_fixture()
      created_clock = clock_fixture(%{user_id: user.id})
      clock = TimeManagement.get_user_clock(user.id)

      assert clock == created_clock
    end

    test "create_user_clock/1 User has no clock" do
      user = user_fixture()
      {:ok, clock} = TimeManagement.create_user_clock(user.id)

      assert clock.user_id == user.id
      assert clock.status == false
    end

    test "find_or_create_user_clock/1 User has no clock. Create one" do
      user = user_fixture()
      assert TimeManagement.get_user_clock(user.id) == nil

      new_clock = TimeManagement.find_or_create_user_clock(user.id)
      assert TimeManagement.get_user_clock(user.id) == new_clock

      clock = TimeManagement.find_or_create_user_clock(user.id)
      assert TimeManagement.get_user_clock(user.id) == clock
    end

    test "find_or_create_user_clock/1 User already has clock. Find it" do
      user = user_fixture()
      {:ok, new_clock} = TimeManagement.create_user_clock(user.id)

      clock = TimeManagement.find_or_create_user_clock(user.id)
      assert new_clock == clock
    end

    test "toggle_user_clock/1 User has no clock. Create one" do
      user = user_fixture()
      {:ok, new_clock} = TimeManagement.toggle_user_clock(user.id)

      assert new_clock.user_id == user.id
      assert new_clock.status == true
    end

    test "toggle_user_clock/1 Toggle twice" do
      user = user_fixture()

      {:ok, clock1} = TimeManagement.toggle_user_clock(user.id)
      assert clock1.status == true
      assert clock1 == TimeManagement.get_user_clock(user.id)
      assert TimeManagement.list_working_times_by_user(user.id) == []

      {:ok, clock2} = TimeManagement.toggle_user_clock(user.id)
      assert clock2.status == false
      assert clock2 = TimeManagement.get_user_clock(user.id)
      [working_time] = TimeManagement.list_working_times_by_user(user.id)
      assert working_time.start == clock1.time
      assert working_time.end != nil
      assert working_time.user_id == user.id
      assert working_time.user_id == clock2.user_id
    end

    test "toggle_user_clock/1 Toggle 3 times" do
      user = user_fixture()

      {:ok, clock1} = TimeManagement.toggle_user_clock(user.id)
      assert clock1.status == true
      assert clock1 == TimeManagement.get_user_clock(user.id)

      {:ok, clock2} = TimeManagement.toggle_user_clock(user.id)
      assert clock2.status == false
      assert clock2 == TimeManagement.get_user_clock(user.id)

      {:ok, clock3} = TimeManagement.toggle_user_clock(user.id)
      assert clock3.status == true
      assert clock3 == TimeManagement.get_user_clock(user.id)
    end

    test "toggle_user_clock/1 Toggle many times" do
      user = user_fixture()

      Enum.each(0..99, fn(i) ->
        {:ok, clock} = TimeManagement.toggle_user_clock(user.id)
        working_times = TimeManagement.list_working_times_by_user(user.id)

        if rem(i, 2) == 0 do
          assert clock.status == true
          length(working_times) == i
        else
          assert clock.status == false
          length(working_times) == i - 1
        end
      end)
    end


  end

    describe "working_times" do
      alias Todolist.TimeManagement.WorkingTime

    import Todolist.AccountFixtures
    import Todolist.TimeManagementFixtures

      @invalid_attrs %{end: nil, start: nil}

      test "list_working_times/0 returns all working_times" do
        user = user_fixture()
        working_time = working_time_fixture(%{user_id: user.id})
        assert TimeManagement.list_working_times() == [working_time]
      end

      test "get_working_time!/1 returns the working_time with given id" do
        user = user_fixture()
        working_time = working_time_fixture(%{user_id: user.id})
        assert TimeManagement.get_working_time(working_time.id) == working_time
      end

      test "create_working_time/1 with valid data creates a working_time" do
        user = user_fixture()
        valid_attrs = %{end: ~U[2022-10-24 09:38:00Z], start: ~U[2022-10-24 09:38:00Z], user_id: user.id}

        assert {:ok, %WorkingTime{} = working_time} = TimeManagement.create_working_time(valid_attrs)
        assert working_time.end == ~U[2022-10-24 09:38:00Z]
        assert working_time.start == ~U[2022-10-24 09:38:00Z]
        assert working_time.user_id == user.id
      end

      test "create_working_time/1 with invalid data returns error changeset" do
        assert {:error, %Ecto.Changeset{}} = TimeManagement.create_working_time(@invalid_attrs)
      end

      test "update_working_time/2 with valid data updates the working_time" do
        user = user_fixture()
        working_time = working_time_fixture(%{user_id: user.id})
        update_attrs = %{end: ~U[2022-10-25 09:38:00Z], start: ~U[2022-10-25 09:38:00Z]}

        assert {:ok, %WorkingTime{} = working_time} = TimeManagement.update_working_time(working_time, update_attrs)
        assert working_time.end == ~U[2022-10-25 09:38:00Z]
        assert working_time.start == ~U[2022-10-25 09:38:00Z]
      end

      test "update_working_time/2 with invalid data returns error changeset" do
        user = user_fixture()
        working_time = working_time_fixture(%{user_id: user.id})
        assert {:error, %Ecto.Changeset{}} = TimeManagement.update_working_time(working_time, @invalid_attrs)
        assert working_time == TimeManagement.get_working_time(working_time.id)
      end

      test "delete_working_time/1 deletes the working_time" do
        user = user_fixture()
        working_time = working_time_fixture(%{user_id: user.id})
        assert {:ok, %WorkingTime{}} = TimeManagement.delete_working_time(working_time)
        assert nil == TimeManagement.get_working_time(working_time.id)
      end

      test "change_working_time/1 returns a working_time changeset" do
        user = user_fixture()
        working_time = working_time_fixture(%{user_id: user.id})
        assert %Ecto.Changeset{} = TimeManagement.change_working_time(working_time)
      end
    end
end
