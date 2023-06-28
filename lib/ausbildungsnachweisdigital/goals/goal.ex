defmodule Ausbildungsnachweisdigital.Goals.Goal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "goals" do
    field :completed, :boolean, default: false
    field :content, :string
    field :deadline, :date
    field :title, :string
    field :apprentice_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:title, :content, :deadline, :completed])
    |> validate_required([:title, :content, :deadline, :completed])
  end
end
