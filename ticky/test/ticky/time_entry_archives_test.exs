defmodule Ticky.TimeEntryArchivesTest do
  use Ticky.DataCase

  alias Ticky.TimeEntryArchives

  describe "time_entry_archives" do
    alias Ticky.TimeEntryArchives.TimeEntryArchive

    import Ticky.TimeEntryArchivesFixtures

    @invalid_attrs %{name: nil}

    test "list_time_entry_archives/0 returns all time_entry_archives" do
      time_entry_archive = time_entry_archive_fixture()
      assert TimeEntryArchives.list_time_entry_archives() == [time_entry_archive]
    end

    test "get_time_entry_archive!/1 returns the time_entry_archive with given id" do
      time_entry_archive = time_entry_archive_fixture()
      assert TimeEntryArchives.get_time_entry_archive!(time_entry_archive.id) == time_entry_archive
    end

    test "create_time_entry_archive/1 with valid data creates a time_entry_archive" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %TimeEntryArchive{} = time_entry_archive} = TimeEntryArchives.create_time_entry_archive(valid_attrs)
      assert time_entry_archive.name == "some name"
    end

    test "create_time_entry_archive/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeEntryArchives.create_time_entry_archive(@invalid_attrs)
    end

    test "update_time_entry_archive/2 with valid data updates the time_entry_archive" do
      time_entry_archive = time_entry_archive_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %TimeEntryArchive{} = time_entry_archive} = TimeEntryArchives.update_time_entry_archive(time_entry_archive, update_attrs)
      assert time_entry_archive.name == "some updated name"
    end

    test "update_time_entry_archive/2 with invalid data returns error changeset" do
      time_entry_archive = time_entry_archive_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeEntryArchives.update_time_entry_archive(time_entry_archive, @invalid_attrs)
      assert time_entry_archive == TimeEntryArchives.get_time_entry_archive!(time_entry_archive.id)
    end

    test "delete_time_entry_archive/1 deletes the time_entry_archive" do
      time_entry_archive = time_entry_archive_fixture()
      assert {:ok, %TimeEntryArchive{}} = TimeEntryArchives.delete_time_entry_archive(time_entry_archive)
      assert_raise Ecto.NoResultsError, fn -> TimeEntryArchives.get_time_entry_archive!(time_entry_archive.id) end
    end

    test "change_time_entry_archive/1 returns a time_entry_archive changeset" do
      time_entry_archive = time_entry_archive_fixture()
      assert %Ecto.Changeset{} = TimeEntryArchives.change_time_entry_archive(time_entry_archive)
    end
  end
end
