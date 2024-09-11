defmodule TickyWeb.PageController do
  use TickyWeb, :controller

  def home(conn, _params) do
    if conn.assigns[:current_user] do
      redirect(conn, to: "/home")
    else
      render(conn, "home.html")
    end
  end
end
