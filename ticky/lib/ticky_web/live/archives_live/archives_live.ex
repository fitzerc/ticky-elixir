defmodule TickyWeb.ArchivesLive do
  use TickyWeb, :live_view

  alias Ticky.{TimeEntryArchives}

  def mount(_params, _session, socket) do
    archived_entries =
      TimeEntryArchives.list_users_time_entry_archives(socket.assigns.current_user.id)

    socket = assign(socket, archived_entries: archived_entries)

    {:ok, socket}
  end

  def handle_event("download_archive", %{"archive_id" => params}, socket) do
  end
end
