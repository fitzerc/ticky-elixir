defmodule Ticky.Repo.Migrations.CreateTimeEntryArchives do
  use Ecto.Migration

  def change do
    create table(:time_entry_archives) do
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:time_entry_archives, [:user_id])
  end
end
