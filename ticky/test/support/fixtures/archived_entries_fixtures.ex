defmodule Ticky.ArchivedEntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ticky.ArchivedEntries` context.
  """

  @doc """
  Generate a archived_entry.
  """
  def archived_entry_fixture(attrs \\ %{}) do
    {:ok, archived_entry} =
      attrs
      |> Enum.into(%{

      })
      |> Ticky.ArchivedEntries.create_archived_entry()

    archived_entry
  end
end
