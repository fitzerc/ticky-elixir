defmodule TickyWeb.StartTimerLive do
  use TickyWeb, :live_view

  alias Ticky.{Timers, Timers.Timer}

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        form: to_form(Timers.change_timer(%Timer{}))
      )

    {:ok, socket}
  end
end
