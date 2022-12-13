defmodule AquebraWeb.NeededDonationController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.NeededDonation

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    neededdonations = Logistic.list_neededdonations()
    render(conn, "index.json", neededdonations: neededdonations)
  end

  def create(conn, %{"needed_donation" => needed_donation_params}) do
    with {:ok, %NeededDonation{} = needed_donation} <- Logistic.create_needed_donation(needed_donation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.needed_donation_path(conn, :show, needed_donation))
      |> render("show.json", needed_donation: needed_donation)
    end
  end

  def show(conn, %{"id" => id}) do
    needed_donation = Logistic.get_needed_donation!(id)
    render(conn, "show.json", needed_donation: needed_donation)
  end

  def update(conn, %{"id" => id, "needed_donation" => needed_donation_params}) do
    needed_donation = Logistic.get_needed_donation!(id)

    with {:ok, %NeededDonation{} = needed_donation} <-
           Logistic.update_needed_donation(needed_donation, needed_donation_params) do
      render(conn, "show.json", needed_donation: needed_donation)
    end
  end

  def delete(conn, %{"id" => id}) do
    needed_donation = Logistic.get_needed_donation!(id)

    with {:ok, %NeededDonation{}} <- Logistic.delete_needed_donation(needed_donation) do
      send_resp(conn, :no_content, "")
    end
  end
end
