defmodule Ticky.TimeEntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ticky.TimeEntries` context.
  """

  @doc """
  Generate a time_entry.
  """
  def time_entry_fixture(attrs \\ %{}) do
    {:ok, time_entry} =
      attrs
      |> Enum.into(%{
        elapsed: "some elapsed",
        ended_at: ~N[2024-09-08 19:52:00],
        project: "some project",
        started_at: ~N[2024-09-08 19:52:00],
        tag: "some tag",
        task: "some task"
      })
      |> Ticky.TimeEntries.create_time_entry()

    time_entry
  end
end
