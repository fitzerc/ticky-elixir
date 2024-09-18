defmodule Ticky.TimeEntryArchives.TimeEntryArchive do
  use Ecto.Schema
  import Ecto.Changeset

  schema "time_entry_archives" do
    field :name, :string
    belongs_to :user, Ticky.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(time_entry_archive, attrs) do
    time_entry_archive
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
