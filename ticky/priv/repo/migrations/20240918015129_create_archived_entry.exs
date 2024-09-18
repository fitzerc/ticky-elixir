defmodule Ticky.Repo.Migrations.CreateArchivedEntry do
  use Ecto.Migration

  def change do
    create table(:archived_entry) do
      add :time_entry_archive_id, references(:time_entry_archives, on_delete: :delete_all)
      add :time_entry_id, references(:time_entries, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:archived_entry, [:user_id])
  end
end
