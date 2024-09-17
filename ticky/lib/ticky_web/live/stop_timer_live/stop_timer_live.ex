defmodule TickyWeb.StopTimerLive do
  use TickyWeb, :live_view

  alias Ticky.{Timers, Timers.Timer, TimeEntries, TimeEntries.TimeEntry}

  def mount(%{"id" => id}, _session, socket) do
    timezone = get_connect_params(socket)["timezone"] || "UTC"
    socket = assign(socket, timezone: timezone)

    timer = Timers.get_timer!(id)
    socket = assign(socket, timer: timer)

    timezone = socket.assigns.timezone
    local_datetime = Timex.now(timezone)

    time_entry = map_timer_to_time_entry(timer, local_datetime)

    {:ok, assign(socket, form: to_form(TimeEntries.change_time_entry(time_entry)))}
  end

  def map_timer_to_time_entry(timer, current_datetime) do
    elapsed_seconds = DateTime.diff(current_datetime, timer.inserted_at, :second)

    {hours, minutes, seconds} = calculate_time_components(elapsed_seconds)

    elapsed_string =
      "#{pad_zero(hours)}:#{pad_zero(minutes)}:#{pad_zero(seconds)}"

    %TimeEntry{
      project: timer.project,
      task: timer.task,
      tag: timer.tag,
      user_id: timer.user_id,
      started_at: timer.started_at,
      ended_at: current_datetime,
      elapsed: elapsed_string
    }
  end

  def handle_event("stop", %{"time_entry" => params}, socket) do
    case TimeEntries.create_time_entry(socket.assigns.current_user, params) do
      {:ok, _time_entry} ->
        _ = Timers.delete_timer(socket.assigns.timer)
        {:noreply, push_navigate(socket, to: ~p"/home")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp calculate_time_components(total_seconds) do
    hours = div(total_seconds, 3600)
    minutes = div(rem(total_seconds, 3600), 60)
    seconds = rem(total_seconds, 60)
    {hours, minutes, seconds}
  end

  defp pad_zero(value) do
    case value do
      v when v < 10 -> "0#{v}"
      _ -> "#{value}"
    end
  end
end
