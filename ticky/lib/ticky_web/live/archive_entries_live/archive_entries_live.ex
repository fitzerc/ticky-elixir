defmodule TickyWeb.ArchiveEntriesLive do
  use TickyWeb, :live_view

  alias Ticky.{
    DateRanges,
    DateRanges.DateRange,
    TimeEntries,
    ArchivedEntries,
    TimeEntryArchives,
    TimeEntryArchives.TimeEntryArchive
  }

  def mount(_params, _session, socket) do
    timezone = get_connect_params(socket)["timezone"] || "UTC"
    socket = assign(socket, timezone: timezone)
    socket = assign(socket, form: to_form(DateRanges.change_date_range(%DateRange{})))

    socket =
      assign(socket,
        archive_form: to_form(TimeEntryArchives.change_time_entry_archive(%TimeEntryArchive{}))
      )

    user_time_entries =
      TimeEntries.list_users_unarchived_time_entries(socket.assigns.current_user.id)

    socket = assign(socket, time_entries: user_time_entries)

    {:ok, socket}
  end

  def handle_event(
        "filter",
        %{"date_range" => %{"from_date" => from_date, "to_date" => to_date}},
        socket
      ) do
    if from_date == "" or to_date == "" do
      {:noreply, put_flash(socket, :error, "One or both dates are empty")}
    else
      iso_from_date = Date.from_iso8601!(from_date)
      naive_from_date = NaiveDateTime.new(iso_from_date, ~T[00:00:00])

      naive_from_date =
        case naive_from_date do
          {:ok, dt} -> dt
          _ -> raise "Invalid from_date"
        end

      iso_to_date = Date.from_iso8601!(to_date)
      naive_to_date = NaiveDateTime.new(iso_to_date, ~T[00:00:00])

      naive_to_date =
        case naive_to_date do
          {:ok, dt} -> dt
          _ -> raise "Invalid to_date"
        end

      updated_time_entries =
        TimeEntries.list_time_entries_between_for_user(
          naive_from_date,
          naive_to_date,
          socket.assigns.current_user.id
        )

      socket = assign(socket, time_entries: updated_time_entries)

      {:noreply, socket}
    end
  end

  def handle_event("archive", %{"time_entry_archive" => archive_name}, socket) do
    time_entries = socket.assigns.time_entries

    cond do
      Enum.empty?(time_entries) ->
        {:noreply, put_flash(socket, :error, "No time entries to archive")}

      archive_name == "" ->
        {:noreply, put_flash(socket, :error, "Invalid Archive Name")}

      true ->
        write_archive_and_entries(archive_name, time_entries, socket)
    end
  end

  defp write_archive_and_entries(archive_name, time_entries, socket) do
    case(
      TimeEntryArchives.create_time_entry_archive(socket.assigns.current_user, archive_name)
    ) do
      {:ok, archived_entry} ->
        IO.inspect(archived_entry)

        time_entry_ids = Enum.map(time_entries, fn entry -> entry.id end)

        case(ArchivedEntries.insert_time_entries(archived_entry.id, time_entry_ids)) do
          :ok ->
            {:noreply, socket}

          {:error, _} ->
            {:noreply, socket}
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
