defmodule Aquebra.Logistic.ReceivingEntity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "receivingentities" do
    field :businessHoursClosing, :string
    field :businessHoursOpening, :string
    field :name, :string
    field :userId, :id
    field :documentNumberId, :id
    field :addressId, :id

    timestamps()
  end

  @doc false
  def changeset(receiving_entity, attrs) do
    receiving_entity
    |> cast(attrs, [:name, :businessHoursOpening, :businessHoursClosing])
    |> validate_required([:name, :businessHoursOpening, :businessHoursClosing])
  end
end
