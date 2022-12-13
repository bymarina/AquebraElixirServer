defmodule Aquebra.Logistic.DonationMatch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "donationmatches" do
    field :donorEntityDonationId, :id
    field :neededDonationId, :id
    field :volunteerId, :id

    timestamps()
  end

  def changeset(donation_match, attrs) do
    donation_match
    |> cast(attrs, [:donorEntityDonationId, :neededDonationId, :volunteerId])
    |> validate_required([:donorEntityDonationId, :neededDonationId, :volunteerId])
  end
end
