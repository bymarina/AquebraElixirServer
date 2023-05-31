defmodule Aquebra.Logistic.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :quantity, :float
    field :type, :string
    field :donor_entity_id, :id
    field :receiving_entity_id, :id
    field :volunteer_id, :id
    field :stock_id, :id

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:type, :quantity])
    |> validate_required([:type, :quantity])
  end
end
