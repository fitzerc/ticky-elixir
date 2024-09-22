defmodule Ticky.ArchivedEntries.ArchivedEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "archived_entry" do
    field :time_entry_archive_id, :integer
    field :time_entry_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(archived_entry, attrs) do
    archived_entry
    |> cast(attrs, [:time_entry_archive_id, :time_entry_id])
    |> validate_required([:time_entry_archive_id, :time_entry_id])
  end
end
