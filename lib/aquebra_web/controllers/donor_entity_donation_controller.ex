defmodule AquebraWeb.DonorEntityDonationController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.DonorEntityDonation

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    donorentitydonation = Logistic.list_donor_entity_donation()
    render(conn, "index.json", donorentitydonation: donorentitydonation)
  end

  def create(conn, %{"donor_entity_donation" => donor_entity_donation_params}) do
    with {:ok, %DonorEntityDonation{} = donor_entity_donation} <-
           Logistic.create_donor_entity_donation(donor_entity_donation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.donor_entity_donation_path(conn, :show, donor_entity_donation))
      |> render("show.json", donor_entity_donation: donor_entity_donation)
    end
  end

  def show(conn, %{"id" => id}) do
    donor_entity_donation = Logistic.get_donor_entity_donation!(id)
    render(conn, "show.json", donor_entity_donation: donor_entity_donation)
  end

  def update(conn, %{"id" => id, "donor_entity_donation" => donor_entity_donation_params}) do
    donor_entity_donation = Logistic.get_donor_entity_donation!(id)

    with {:ok, %DonorEntityDonation{} = donor_entity_donation} <-
           Logistic.update_donor_entity_donation(donor_entity_donation, donor_entity_donation_params) do
      render(conn, "show.json", donor_entity_donation: donor_entity_donation)
    end
  end

  def delete(conn, %{"id" => id}) do
    donor_entity_donation = Logistic.get_donor_entity_donation!(id)

    with {:ok, %DonorEntityDonation{}} <- Logistic.delete_donor_entity_donation(donor_entity_donation) do
      send_resp(conn, :no_content, "")
    end
  end
end
