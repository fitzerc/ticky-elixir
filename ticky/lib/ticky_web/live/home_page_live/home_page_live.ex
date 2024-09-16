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

  def handle_event("show_today", _value, socket) do
    date = Date.utc_today()
    datetime = DateTime.new!(date, ~T[00:00:00])
    todays_entries = TimeEntries.get_time_entries_for_day(socket.assigns.current_user.id, datetime)
    socket = assign(socket, time_entries: todays_entries)
    {:noreply, socket}
  end
end
