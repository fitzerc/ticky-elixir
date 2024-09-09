defmodule Ticky.TimeEntries.TimeEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "time_entries" do
    field :tag, :string
    field :started_at, :naive_datetime
    field :task, :string
    field :project, :string
    field :ended_at, :naive_datetime
    field :elapsed, :string
    belongs_to :user, Ticky.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(time_entry, attrs) do
    time_entry
    |> cast(attrs, [:project, :task, :tag, :started_at, :ended_at, :elapsed, :user_id])
    |> validate_required([:project, :task, :tag, :started_at, :ended_at, :elapsed, :user_id])
  end
end
