defmodule Aquebra.Logistic.DonationMatch do
  use Ecto.Schema
  import Ecto.Changeset
  alias Aquebra.Logistic
  alias Aquebra.Logistic.DonationProduct
  alias Aquebra.Logistic.NeededDonation
  alias Aquebra.Logistic.Stock

  @required_fields [:donorEntityDonationId, :neededDonationId, :volunteerId, :donorEntityId, :receivingEntityId, :quantity]
  @optional_fields []

  schema "donationmatches" do
    field :donorEntityDonationId, :id
    field :neededDonationId, :id
    field :volunteerId, :id
    field :donorEntityId, :id
    field :receivingEntityId, :id
    field :quantity, :string

    timestamps()
  end

  def changeset(donation_match, attrs) do
    donation_match
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def match(donor_entity_id, vehicle_capacity, volunteer_id) do
#    Logistic.get_stock_by_entity_id(donor_entity_id)
#    |> Enum.each(fn stock ->
#      Logistic.get_needed_donation_by_type(stock.type)
#      |> Enum.each(fn demand ->
#        if demand do
#          match_params = %{donorEntityDonationId: he, neededDonationId: demand.id, volunteerId: volunteer_id, donorEntityId: donor_entity_id, receivingEntityId: demand.receivingEntityId, quantity: stock.quantity}
#          Logistic.create_donation_match(match_params)
#        end
#      end)
#    end)

#    |> IO.inspect

    # Pega o estoque do ponto de coleta selecionado
    # Verifica o primeiro, cabe tudo no carro?
      # Sim: cria o match, verifica se o próximo cabe inteiro
      # Não: verifica se cabe alguma parte, cria o match
        #Não: acabou

        # para cada match, uma baixa no estoque

  end

  def find_receiving_entity_id(demand_id),
    do: Logistic.get_needed_donation!(demand_id).receivingEntityId

end
