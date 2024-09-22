defmodule Ticky.DateRanges.DateRange do
  use Ecto.Schema
  import Ecto.Changeset

  schema "date_range" do
    field :from_date, :naive_datetime
    field :to_date, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(date_range, attrs) do
    date_range
    |> cast(attrs, [:from_date, :to_date])
    |> validate_required([:from_date, :to_date])
  end
end
