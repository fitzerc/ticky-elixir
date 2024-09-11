defmodule TickyWeb.HomePageLive do
  use TickyWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
