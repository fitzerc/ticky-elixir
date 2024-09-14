defmodule TickyWeb.HomePageLive do
  use TickyWeb, :live_view

  alias Ticky.Timers

  def mount(_params, _session, socket) do
    user_timers = Timers.list_users_timers(socket.assigns.current_user.id)
    socket = assign(socket, timers: user_timers)
    {:ok, socket}
  end

  def handle_event("nav_to_page", _value, socket) do
    {:noreply, push_navigate(socket, to: ~p"/start_timer")}
  end
end
