defmodule TickyWeb.ArchivesLive do
  use TickyWeb, :live_view

  alias Ticky.{TimeEntryArchives, TimeEntries, TimeEntries.TimeEntry}

  def mount(_params, _session, socket) do
    archived_entries =
      TimeEntryArchives.list_users_time_entry_archives(socket.assigns.current_user.id)

    socket = assign(socket, archived_entries: archived_entries)

    {:ok, socket}
  end

  def handle_event(
        "download_csv",
        %{"archive_id" => archive_id, "archive_name" => archive_name},
        socket
      ) do
    time_entries = TimeEntries.list_time_entries_by_archive(archive_id)
    csv_content = generate_csv(time_entries)

    filename = "time_entries_#{archive_name}.csv"

    {:noreply,
     socket
     |> put_flash(:info, "CSV generated successfully")
     |> push_event("download_csv", %{csv: csv_content, filename: filename})}
  end

  def generate_csv(time_entries) do
    headers = ["project", "task", "tag", "started_at", "ended_at", "elapsed"]

    rows =
      Enum.map(time_entries, fn %TimeEntry{
                                  project: project,
                                  task: task,
                                  tag: tag,
                                  started_at: started_at,
                                  ended_at: ended_at,
                                  elapsed: elapsed
                                } ->
        [project, task, tag, started_at, ended_at, elapsed]
      end)

    [headers | rows]
    |> CSV.encode()
    # |> Enum.to_list()
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.join("\n")
  end
end
