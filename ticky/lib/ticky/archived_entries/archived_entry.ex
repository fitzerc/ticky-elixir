defmodule Ticky.ArchivedEntries.ArchivedEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "archived_entry" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(archived_entry, attrs) do
    archived_entry
    |> cast(attrs, [])
    |> validate_required([])
  end
end
