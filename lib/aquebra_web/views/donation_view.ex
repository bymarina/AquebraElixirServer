defmodule AquebraWeb.DonationView do
  use AquebraWeb, :view
  alias AquebraWeb.DonationView

  def render("index.json", %{donations: donations}) do
    %{data: render_many(donations, DonationView, "donation.json")}
  end

  def render("show.json", %{donation: donation}) do
    %{data: render_one(donation, DonationView, "donation.json")}
  end

  def render("donation.json", %{donation: donation}) do
    %{
      id: donation.id,
      type: donation.type,
      quantity: donation.quantity
    }
  end
end
