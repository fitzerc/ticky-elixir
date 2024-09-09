defmodule Ticky.Timers.Timer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timers" do
    field :tag, :string
    field :task, :string
    field :project, :string
    belongs_to :user, Ticky.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:project, :task, :tag, :user_id])
    |> validate_required([:project, :task, :tag, :user_id])
  end
end
