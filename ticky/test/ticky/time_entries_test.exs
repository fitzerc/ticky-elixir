defmodule Ticky.TimeEntriesTest do
  use Ticky.DataCase

  alias Ticky.TimeEntries

  describe "time_entries" do
    alias Ticky.TimeEntries.TimeEntry

    import Ticky.TimeEntriesFixtures

    @invalid_attrs %{tag: nil, started_at: nil, task: nil, project: nil, ended_at: nil, elapsed: nil}

    test "list_time_entries/0 returns all time_entries" do
      time_entry = time_entry_fixture()
      assert TimeEntries.list_time_entries() == [time_entry]
    end

    test "get_time_entry!/1 returns the time_entry with given id" do
      time_entry = time_entry_fixture()
      assert TimeEntries.get_time_entry!(time_entry.id) == time_entry
    end

    test "create_time_entry/1 with valid data creates a time_entry" do
      valid_attrs = %{tag: "some tag", started_at: ~N[2024-09-08 19:52:00], task: "some task", project: "some project", ended_at: ~N[2024-09-08 19:52:00], elapsed: "some elapsed"}

      assert {:ok, %TimeEntry{} = time_entry} = TimeEntries.create_time_entry(valid_attrs)
      assert time_entry.tag == "some tag"
      assert time_entry.started_at == ~N[2024-09-08 19:52:00]
      assert time_entry.task == "some task"
      assert time_entry.project == "some project"
      assert time_entry.ended_at == ~N[2024-09-08 19:52:00]
      assert time_entry.elapsed == "some elapsed"
    end

    test "create_time_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeEntries.create_time_entry(@invalid_attrs)
    end

    test "update_time_entry/2 with valid data updates the time_entry" do
      time_entry = time_entry_fixture()
      update_attrs = %{tag: "some updated tag", started_at: ~N[2024-09-09 19:52:00], task: "some updated task", project: "some updated project", ended_at: ~N[2024-09-09 19:52:00], elapsed: "some updated elapsed"}

      assert {:ok, %TimeEntry{} = time_entry} = TimeEntries.update_time_entry(time_entry, update_attrs)
      assert time_entry.tag == "some updated tag"
      assert time_entry.started_at == ~N[2024-09-09 19:52:00]
      assert time_entry.task == "some updated task"
      assert time_entry.project == "some updated project"
      assert time_entry.ended_at == ~N[2024-09-09 19:52:00]
      assert time_entry.elapsed == "some updated elapsed"
    end

    test "update_time_entry/2 with invalid data returns error changeset" do
      time_entry = time_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeEntries.update_time_entry(time_entry, @invalid_attrs)
      assert time_entry == TimeEntries.get_time_entry!(time_entry.id)
    end

    test "delete_time_entry/1 deletes the time_entry" do
      time_entry = time_entry_fixture()
      assert {:ok, %TimeEntry{}} = TimeEntries.delete_time_entry(time_entry)
      assert_raise Ecto.NoResultsError, fn -> TimeEntries.get_time_entry!(time_entry.id) end
    end

    test "change_time_entry/1 returns a time_entry changeset" do
      time_entry = time_entry_fixture()
      assert %Ecto.Changeset{} = TimeEntries.change_time_entry(time_entry)
    end
  end
end
