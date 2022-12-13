defmodule Aquebra.Logistic.TownHallUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "townhallusers" do
    field :name, :string
    field :userId, :id
    field :documentNumberId, :id
    field :AddressId, :id

    timestamps()
  end

  @doc false
  def changeset(town_hall_user, attrs) do
    town_hall_user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
