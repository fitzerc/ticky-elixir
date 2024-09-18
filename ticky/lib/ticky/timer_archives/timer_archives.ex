defmodule Ticky.EntryArchives.EntryArchive do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entry_archives" do
    belongs_to :time_entry_archive, Ticky.TimeEntryArchives.TimeEntryArchive
    belongs_to :time_entry, Ticky.TimeEntries.TimeEntry
  end

  @doc false
  def changeset(entry_archive, attrs) do
    entry_archive
    |> cast(attrs, [:timer_entry_archive, :time_entry])
    |> validate_required([:timer_entry_archive, :time_entry])
  end
end
