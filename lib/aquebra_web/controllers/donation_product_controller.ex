defmodule AquebraWeb.DonationProductController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.DonationProduct

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    donationproducts = Logistic.list_donationproducts()
    render(conn, "index.json", donationproducts: donationproducts)
  end

  def create(conn, %{"donation_product" => donation_product_params}) do
    with {:ok, %DonationProduct{} = donation_product} <- Logistic.create_donation_product(donation_product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.donation_product_path(conn, :show, donation_product))
      |> render("show.json", donation_product: donation_product)
    end
  end

  def show(conn, %{"id" => id}) do
    donation_product = Logistic.get_donation_product!(id)
    render(conn, "show.json", donation_product: donation_product)
  end

  def update(conn, %{"id" => id, "donation_product" => donation_product_params}) do
    donation_product = Logistic.get_donation_product!(id)

    with {:ok, %DonationProduct{} = donation_product} <-
           Logistic.update_donation_product(donation_product, donation_product_params) do
      render(conn, "show.json", donation_product: donation_product)
    end
  end

  def delete(conn, %{"id" => id}) do
    donation_product = Logistic.get_donation_product!(id)

    with {:ok, %DonationProduct{}} <- Logistic.delete_donation_product(donation_product) do
      send_resp(conn, :no_content, "")
    end
  end
end
