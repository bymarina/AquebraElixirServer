defmodule AquebraWeb.NeededDonationView do
  use AquebraWeb, :view
  alias AquebraWeb.NeededDonationView

  def render("index.json", %{neededdonations: neededdonations}) do
    %{data: render_many(neededdonations, NeededDonationView, "needed_donation.json")}
  end

  def render("show.json", %{needed_donation: needed_donation}) do
    %{data: render_one(needed_donation, NeededDonationView, "needed_donation.json")}
  end

  def render("needed_donation.json", %{needed_donation: needed_donation}) do
    %{
      id: needed_donation.id,
      type: needed_donation.type,
      quantity: needed_donation.quantity,
      day: needed_donation.day
    }
  end
end
