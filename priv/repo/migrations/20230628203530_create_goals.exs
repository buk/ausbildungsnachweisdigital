defmodule Ausbildungsnachweisdigital.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :content, :text
      add :deadline, :date
      add :completed, :boolean, default: false, null: false
      add :apprentice_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:goals, [:apprentice_id])
  end
end
