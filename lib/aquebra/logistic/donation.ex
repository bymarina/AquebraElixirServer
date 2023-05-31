defmodule Aquebra.Logistic.Donation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "donations" do
    field :quantity, :float
    field :type, :string
    field :donor_entity_id, :id
    field :receiving_entity_id, :id
    field :volunteer_id, :id
    field :stock_id, :id

    timestamps()
  end

  @doc false
  def changeset(donation, attrs) do
    donation
    |> cast(attrs, [:type, :quantity])
    |> validate_required([:type, :quantity])
  end
end
