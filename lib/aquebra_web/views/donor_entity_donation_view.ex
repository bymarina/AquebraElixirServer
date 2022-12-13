defmodule AquebraWeb.DonorEntityDonationView do
  use AquebraWeb, :view
  alias AquebraWeb.DonorEntityDonationView

  def render("index.json", %{donorentitydonation: donorentitydonation}) do
    %{data: render_many(donorentitydonation, DonorEntityDonationView, "donor_entity_donation.json")}
  end

  def render("show.json", %{donor_entity_donation: donor_entity_donation}) do
    %{data: render_one(donor_entity_donation, DonorEntityDonationView, "donor_entity_donation.json")}
  end

  def render("donor_entity_donation.json", %{donor_entity_donation: donor_entity_donation}) do
    %{
      id: donor_entity_donation.id
    }
  end
end
