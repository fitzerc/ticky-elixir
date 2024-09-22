defmodule Ticky.DateRangesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ticky.DateRanges` context.
  """

  @doc """
  Generate a date_range.
  """
  def date_range_fixture(attrs \\ %{}) do
    {:ok, date_range} =
      attrs
      |> Enum.into(%{
        from_date: ~N[2024-09-18 02:11:00],
        to_date: ~N[2024-09-18 02:11:00]
      })
      |> Ticky.DateRanges.create_date_range()

    date_range
  end
end
