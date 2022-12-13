defmodule AquebraWeb.DonationMatchController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.DonationMatch

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    donationmatches = Logistic.list_donationmatches()
    render(conn, "index.json", donationmatches: donationmatches)
  end

  def create(conn, %{"donation_match" => donation_match_params}) do
    with {:ok, %DonationMatch{} = donation_match} <- Logistic.create_donation_match(donation_match_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.donation_match_path(conn, :show, donation_match))
      |> render("show.json", donation_match: donation_match)
    end
  end

  def show(conn, %{"id" => id}) do
    donation_match = Logistic.get_donation_match!(id)
    render(conn, "show.json", donation_match: donation_match)
  end

  def update(conn, %{"id" => id, "donation_match" => donation_match_params}) do
    donation_match = Logistic.get_donation_match!(id)

    with {:ok, %DonationMatch{} = donation_match} <- Logistic.update_donation_match(donation_match, donation_match_params) do
      render(conn, "show.json", donation_match: donation_match)
    end
  end

  def delete(conn, %{"id" => id}) do
    donation_match = Logistic.get_donation_match!(id)

    with {:ok, %DonationMatch{}} <- Logistic.delete_donation_match(donation_match) do
      send_resp(conn, :no_content, "")
    end
  end
end
