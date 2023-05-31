defmodule AquebraWeb.DonationController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.Donation

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    donations = Logistic.list_donations()
    render(conn, "index.json", donations: donations)
  end

  def create(conn, %{"donation" => donation_params}) do
    with {:ok, %Donation{} = donation} <- Logistic.create_donation(donation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.donation_path(conn, :show, donation))
      |> render("show.json", donation: donation)
    end
  end

  def show(conn, %{"id" => id}) do
    donation = Logistic.get_donation!(id)
    render(conn, "show.json", donation: donation)
  end

  def update(conn, %{"id" => id, "donation" => donation_params}) do
    donation = Logistic.get_donation!(id)

    with {:ok, %Donation{} = donation} <- Logistic.update_donation(donation, donation_params) do
      render(conn, "show.json", donation: donation)
    end
  end

  def delete(conn, %{"id" => id}) do
    donation = Logistic.get_donation!(id)

    with {:ok, %Donation{}} <- Logistic.delete_donation(donation) do
      send_resp(conn, :no_content, "")
    end
  end
end
