defmodule Ticky.TimersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ticky.Timers` context.
  """

  @doc """
  Generate a timer.
  """
  def timer_fixture(attrs \\ %{}) do
    {:ok, timer} =
      attrs
      |> Enum.into(%{
        project: "some project",
        tag: "some tag",
        task: "some task"
      })
      |> Ticky.Timers.create_timer()

    timer
  end
end
