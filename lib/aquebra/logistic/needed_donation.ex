defmodule Aquebra.Logistic.NeededDonation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "neededdonations" do
    field :day, :string
    field :quantity, :integer
    field :type, :string

    timestamps()
  end

  def changeset(needed_donation, attrs) do
    needed_donation
    |> cast(attrs, [:type, :quantity, :day, :receivingEntityId])
    |> validate_required([:type, :quantity, :day, :receivingEntityId])
  end
end
