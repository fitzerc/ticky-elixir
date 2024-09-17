defmodule TickyWeb.HomePageLive do
  use TickyWeb, :live_view

  alias Ticky.{ Timers, TimeEntries }

  def mount(_params, _session, socket) do
    timezone = get_connect_params(socket)["timezone"] || "UTC"
    socket = assign(socket, timezone: timezone)

    user_timers = Timers.list_users_timers(socket.assigns.current_user.id)
    socket = assign(socket, timers: user_timers)

    user_time_entries = get_todays_time_entries(socket)
    socket = assign(socket, time_entries: user_time_entries)

    socket = assign(socket, filter: "today")

    {:ok, socket}
  end

  def handle_event("nav_to_page", _value, socket) do
    {:noreply, push_navigate(socket, to: ~p"/start_timer")}
  end

  def handle_event("stop_timer", %{"id" => id}, socket) do
    {:noreply, push_navigate(socket, to: ~p"/stop_timer?#{[id: id]}")}
  end

  def handle_event("show_today", _value, socket) do
    todays_entries = get_todays_time_entries(socket)
    socket = assign(socket, time_entries: todays_entries)

    socket = assign(socket, filter: "today")

    {:noreply, socket}
  end

  defp get_todays_time_entries(socket) do
    timezone = socket.assigns.timezone
    date = Timex.now(timezone)
    datetime = Timex.set(date, hour: 0, minute: 0, second: 0)

    TimeEntries.get_time_entries_for_day(socket.assigns.current_user.id, datetime)
  end

  def handle_event("show_all", _value, socket) do
    user_time_entries = TimeEntries.list_users_time_entries(socket.assigns.current_user.id)
    socket = assign(socket, time_entries: user_time_entries)

    socket = assign(socket, filter: "all")

    {:noreply, socket}
  end
end
