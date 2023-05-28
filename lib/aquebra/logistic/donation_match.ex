defmodule Aquebra.Logistic.DonationMatch do
  use Ecto.Schema
  import Ecto.Changeset
  alias Aquebra.Logistic.DonationProduct
  alias Aquebra.Logistic.NeededDonation

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

  def match() do
    needed_donations = Logistic.list_neededdonations()
    donation_products = Logistic.list_donationproducts()

    # se der match em tipo de produto e donation_product tem pelo menos a quantidade necessária do alimento
    # com donation_product_id vai pra donorentitydonation e pega o donorEntityId
    # pega receivingEntityId de needed_donations
    # salva o match

    Enum.each(donation_products, fn donated_product ->
      if donated_product.type do
      end
    end)

    # vamos simular uma redução de estoque?
    # vamos considerar que sempre temos o estoque cheio?
    # vamos simular um dia completo de entregas? se sim vamos precisar contabilizar o alimento a cada voluntário 
  end
end
