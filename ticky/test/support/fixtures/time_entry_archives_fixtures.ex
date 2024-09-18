defmodule Ticky.TimeEntryArchivesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ticky.TimeEntryArchives` context.
  """

  @doc """
  Generate a time_entry_archive.
  """
  def time_entry_archive_fixture(attrs \\ %{}) do
    {:ok, time_entry_archive} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Ticky.TimeEntryArchives.create_time_entry_archive()

    time_entry_archive
  end
end
