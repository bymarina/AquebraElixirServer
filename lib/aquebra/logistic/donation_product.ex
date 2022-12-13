defmodule Aquebra.Logistic.DonationProduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "donationproducts" do
    field :day, :string
    field :quantity, :integer
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(donation_product, attrs) do
    donation_product
    |> cast(attrs, [:type, :quantity, :day])
    |> validate_required([:type, :quantity, :day])
  end
end
