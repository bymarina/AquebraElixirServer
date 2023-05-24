defmodule Aquebra.Logistic.Volunteer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "volunteers" do
    field :name, :string
    field :picture, :string
    field :vehicleCapacity, :integer
    field :userId, :id
    field :documentNumberId, :id
    field :originAddressId, :id
    field :destinyAddressId, :id

    timestamps()
  end

  @doc false
  def changeset(volunteer, attrs) do
    volunteer
    |> cast(attrs, [:name, :vehicleCapacity, :picture])
    |> validate_required([:name, :vehicleCapacity, :picture])
  end
end
