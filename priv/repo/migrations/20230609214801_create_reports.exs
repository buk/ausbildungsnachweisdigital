defmodule Ausbildungsnachweisdigital.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :activity, :text
      add :duration, :integer
      add :apprentice_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:reports, [:apprentice_id])
  end
end
