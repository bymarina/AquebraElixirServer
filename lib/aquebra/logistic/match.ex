defmodule Aquebra.Logistic.Match do
  use Ecto.Schema
  import Ecto.Changeset
  alias Aquebra.Logistic
  alias Aquebra.Logistic.Stock
  alias Aquebra.Logistic.NeededDonation

  @required_fields [:quantity, :type, :donor_entity_id, :receiving_entity_id, :volunteer_id, :stock_id, :url]
  @optional_fields []

  schema "matches" do
    field :quantity, :float
    field :type, :string
    field :donor_entity_id, :id
    field :receiving_entity_id, :id
    field :volunteer_id, :id
    field :stock_id, :id
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def create_matches_for_volunteer(volunteer_id, donor_entity_id) do
    Logistic.get_stock_by_entity_id(donor_entity_id)
    |> Enum.each(fn stock ->
      demand = find_match_demand_by_type(stock)

      if demand != nil do
        match_params = %{
          type: stock.type,
          quantity: stock.quantity,
          donor_entity_id: donor_entity_id,
          receiving_entity_id: demand.receivingEntityId,
          volunteer_id: volunteer_id,
          stock_id: stock.id
        }

        Logistic.create_match(match_params)
      end
    end)
  end

  def create_match_from_route(volunteer_id, match, quantity, url) do
    type = match.collect_point.donation_type
    donor_entity_id = match.collect_point.entity_id
    receiving_entity_id = match.deliver_point.entity_id
    stock_id = match.collect_point.stock_id

    match_params = %{
      type: type,
      quantity: quantity,
      donor_entity_id: donor_entity_id,
      receiving_entity_id: receiving_entity_id,
      volunteer_id: volunteer_id,
      stock_id: stock_id,
      url: url
    }

    Logistic.create_match(match_params)
    Stock.remove_quantity_from_stock(stock_id, quantity)
  end

  defp find_match_demand_by_type(stock) do
    Logistic.get_needed_donation_by_type(stock.type)
  end

  def find_match_by_volunteer_id(volunteer_id) do
    Logistic.get_match_by_volunteer_id(volunteer_id)
  end

  def delete_match(match_id) do
    Logistic.get_match!(match_id)
  end

  def clean_matches() do
    Logistic.delete_all_matches()
  end
end
