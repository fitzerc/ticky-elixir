defmodule Ticky.ArchivedEntriesTest do
  use Ticky.DataCase

  alias Ticky.ArchivedEntries

  describe "archived_entry" do
    alias Ticky.ArchivedEntries.ArchivedEntry

    import Ticky.ArchivedEntriesFixtures

    @invalid_attrs %{}

    test "list_archived_entry/0 returns all archived_entry" do
      archived_entry = archived_entry_fixture()
      assert ArchivedEntries.list_archived_entry() == [archived_entry]
    end

    test "get_archived_entry!/1 returns the archived_entry with given id" do
      archived_entry = archived_entry_fixture()
      assert ArchivedEntries.get_archived_entry!(archived_entry.id) == archived_entry
    end

    test "create_archived_entry/1 with valid data creates a archived_entry" do
      valid_attrs = %{}

      assert {:ok, %ArchivedEntry{} = archived_entry} = ArchivedEntries.create_archived_entry(valid_attrs)
    end

    test "create_archived_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ArchivedEntries.create_archived_entry(@invalid_attrs)
    end

    test "update_archived_entry/2 with valid data updates the archived_entry" do
      archived_entry = archived_entry_fixture()
      update_attrs = %{}

      assert {:ok, %ArchivedEntry{} = archived_entry} = ArchivedEntries.update_archived_entry(archived_entry, update_attrs)
    end

    test "update_archived_entry/2 with invalid data returns error changeset" do
      archived_entry = archived_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = ArchivedEntries.update_archived_entry(archived_entry, @invalid_attrs)
      assert archived_entry == ArchivedEntries.get_archived_entry!(archived_entry.id)
    end

    test "delete_archived_entry/1 deletes the archived_entry" do
      archived_entry = archived_entry_fixture()
      assert {:ok, %ArchivedEntry{}} = ArchivedEntries.delete_archived_entry(archived_entry)
      assert_raise Ecto.NoResultsError, fn -> ArchivedEntries.get_archived_entry!(archived_entry.id) end
    end

    test "change_archived_entry/1 returns a archived_entry changeset" do
      archived_entry = archived_entry_fixture()
      assert %Ecto.Changeset{} = ArchivedEntries.change_archived_entry(archived_entry)
    end
  end
end
