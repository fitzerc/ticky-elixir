defmodule Ticky.Timers.Timer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timers" do
    field :tag, :string
    field :task, :string
    field :project, :string
    field :started_at, :naive_datetime
    belongs_to :user, Ticky.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:project, :task, :tag, :started_at, :user_id])
    |> validate_required([:project, :task, :user_id])
  end
end
