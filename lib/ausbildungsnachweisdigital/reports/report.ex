defmodule Ausbildungsnachweisdigital.Reports.Report do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reports" do
    field :activity, :string
    field :duration, :integer
    field :apprentice_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:activity, :duration])
    |> validate_required([:activity, :duration])
  end
end
