defmodule Todolist.Repo.Migrations.CreateTeamRelations do
  use Ecto.Migration

  def change do
    create table(:employees_teams, primary_key: false) do
      add(:user_id, references(:users, on_delete: :nothing), primary_key: true)
      add(:team_id, references(:teams, on_delete: :nothing), primary_key: true)
    end

    create(unique_index(:employees_teams, [:user_id, :team_id]))

    create table(:managers_teams, primary_key: false) do
      add(:user_id, references(:users, on_delete: :nothing), primary_key: true)
      add(:team_id, references(:teams, on_delete: :nothing), primary_key: true)
    end

    create(unique_index(:managers_teams, [:user_id, :team_id]))
  end
end
