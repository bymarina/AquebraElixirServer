defmodule Aquebra.Logistic.DonorEntityDonation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "donorentitydonation" do
    field :donorEntityId, :id
    field :donationId, :id

    timestamps()
  end

  @doc false
  def changeset(donor_entity_donation, attrs) do
    donor_entity_donation
    |> cast(attrs, [:donorEntityId, :donationId])
    |> validate_required([:donorEntityId, :donationId])
  end
end
