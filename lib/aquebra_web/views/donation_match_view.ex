defmodule AquebraWeb.DonationMatchView do
  use AquebraWeb, :view
  alias AquebraWeb.DonationMatchView

  def render("index.json", %{donationmatches: donationmatches}) do
    %{data: render_many(donationmatches, DonationMatchView, "donation_match.json")}
  end

  def render("show.json", %{donation_match: donation_match}) do
    %{data: render_one(donation_match, DonationMatchView, "donation_match.json")}
  end

  def render("donation_match.json", %{donation_match: donation_match}) do
    %{
      id: donation_match.id
    }
  end
end
