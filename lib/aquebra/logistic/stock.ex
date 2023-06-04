defmodule Aquebra.Logistic.Stock do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  alias Aquebra.Logistic
  alias Aquebra.Logistic.DonationProduct
  alias Aquebra.Logistic.DonorEntity
  alias Aquebra.Logistic.DonorEntityDonation

  @required_fields [:type, :quantity, :donorEntityId]
  @optional_fields []

  schema "stocks" do
    field :quantity, :float
    field :type, :string
    field :donorEntityId, :id

    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def start_stock() do
    donation_products = Logistic.list_donationproducts()

    Enum.each(donation_products, fn product ->
      type = product.type
      quantity = product.quantity
      donor_id = find_donation_entity_id(product.id)
      stock = %{type: type, quantity: quantity, donorEntityId: donor_id}
      Logistic.create_stock(stock)
    end)
  end

  def find_donation_entity_id(donation_id),
    do: Logistic.get_entity_id_from_donor_entity_donation_by_donation_id(donation_id).donorEntityId

  def remove_quantity_from_stock(donation_id, quantity_to_remove) do
    stock = Logistic.get_stock!(donation_id)

    if quantity_to_remove <= stock.quantity do
      new_quantity = stock.quantity - quantity_to_remove
      stock_params = %{type: stock.type, quantity: new_quantity, donorEntityId: stock.donorEntityId}
      Logistic.update_stock(stock, stock_params)
    else
      Logger.info(
        "Failed to update the donation id: #{donation_id} with the new quantity #{inspect(stock.quantity - quantity_to_remove)}"
      )
    end
  end

  def clean_stock() do
    Logistic.delete_all_stock()
  end

end
