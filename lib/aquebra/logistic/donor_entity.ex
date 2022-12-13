defmodule Aquebra.Logistic.DonorEntity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "donorentities" do
    field :businessHoursClosing, :string
    field :businessHoursOpening, :string
    field :name, :string
    field :userId, :id
    field :documentNumberId, :id
    field :addressId, :id

    timestamps()
  end

  @doc false
  def changeset(donor_entity, attrs) do
    donor_entity
    |> cast(attrs, [:name, :businessHoursOpening, :businessHoursClosing])
    |> validate_required([:name, :businessHoursOpening, :businessHoursClosing])
  end
end
