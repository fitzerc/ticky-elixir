defmodule Ticky.Repo.Migrations.CreateTimers do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :project, :string
      add :task, :string
      add :tag, :string
      add :started_at, :naive_datetime
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:timers, [:user_id])
  end
end
