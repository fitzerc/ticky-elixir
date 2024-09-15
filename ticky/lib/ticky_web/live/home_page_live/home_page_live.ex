defmodule TickyWeb.HomePageLive do
  use TickyWeb, :live_view

  alias Ticky.{ Timers, TimeEntries }

  def mount(_params, _session, socket) do
    user_timers = Timers.list_users_timers(socket.assigns.current_user.id)
    socket = assign(socket, timers: user_timers)

    user_time_entries = TimeEntries.list_users_time_entries(socket.assigns.current_user.id)
    socket = assign(socket, time_entries: user_time_entries)

    {:ok, socket}
  end

  def handle_event("nav_to_page", _value, socket) do
    {:noreply, push_navigate(socket, to: ~p"/start_timer")}
  end

  def handle_event("stop_timer", %{"id" => id}, socket) do
    {:noreply, push_navigate(socket, to: ~p"/stop_timer?#{[id: id]}")}
  end
end
