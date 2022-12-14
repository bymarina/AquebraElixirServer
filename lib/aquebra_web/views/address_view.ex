defmodule AquebraWeb.AddressView do
  use AquebraWeb, :view
  alias AquebraWeb.AddressView

  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{address: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{
      id: address.id,
      cep: address.cep,
      number: address.number,
      street: address.street,
      complement: address.complement,
      coordinates: address.coordinates
    }
  end
end
