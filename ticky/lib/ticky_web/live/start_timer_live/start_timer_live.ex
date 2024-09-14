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

  def handle_event("start", %{"timer" => params}, socket) do
    case Timers.create_timer(socket.assigns.current_user, params) do
      {:ok, _timer} ->
        changeset = Timers.change_timer(%Timer{})
        {:noreply, assign(socket, :form, to_form(changeset))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  def handle_event("validate", %{"timer" => params}, socket) do
    changeset =
      %Timer{}
      |> Timers.change_timer(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end
end
