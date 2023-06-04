defmodule Aquebra.Logistic.Donation do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:quantity, :type, :donor_entity_id, :receiving_entity_id, :volunteer_id, :stock_id]
  @optional_fields []

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
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
