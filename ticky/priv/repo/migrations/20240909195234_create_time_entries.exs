defmodule Ticky.Repo.Migrations.CreateTimeEntries do
  use Ecto.Migration

  def change do
    create table(:time_entries) do
      add :project, :string
      add :task, :string
      add :tag, :string
      add :started_at, :naive_datetime
      add :ended_at, :naive_datetime
      add :elapsed, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:time_entries, [:user_id])
  end
end
