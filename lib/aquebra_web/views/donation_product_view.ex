defmodule AquebraWeb.DonationProductView do
  use AquebraWeb, :view
  alias AquebraWeb.DonationProductView

  def render("index.json", %{donationproducts: donationproducts}) do
    %{data: render_many(donationproducts, DonationProductView, "donation_product.json")}
  end

  def render("show.json", %{donation_product: donation_product}) do
    %{data: render_one(donation_product, DonationProductView, "donation_product.json")}
  end

  def render("donation_product.json", %{donation_product: donation_product}) do
    %{
      id: donation_product.id,
      type: donation_product.type,
      quantity: donation_product.quantity,
      day: donation_product.day
    }
  end
end
