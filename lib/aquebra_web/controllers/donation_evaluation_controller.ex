defmodule AquebraWeb.Donation_evaluationController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.Donation_evaluation

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    donations_evaluation = Logistic.list_donations_evaluation()
    render(conn, "index.json", donations_evaluation: donations_evaluation)
  end

  def create(conn, %{"donation_evaluation" => donation_evaluation_params}) do
    with {:ok, %Donation_evaluation{} = donation_evaluation} <-
           Logistic.create_donation_evaluation(donation_evaluation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.donation_evaluation_path(conn, :show, donation_evaluation))
      |> render("show.json", donation_evaluation: donation_evaluation)
    end
  end

  def show(conn, %{"id" => id}) do
    donation_evaluation = Logistic.get_donation_evaluation!(id)
    render(conn, "show.json", donation_evaluation: donation_evaluation)
  end

  def update(conn, %{"id" => id, "donation_evaluation" => donation_evaluation_params}) do
    donation_evaluation = Logistic.get_donation_evaluation!(id)

    with {:ok, %Donation_evaluation{} = donation_evaluation} <-
           Logistic.update_donation_evaluation(donation_evaluation, donation_evaluation_params) do
      render(conn, "show.json", donation_evaluation: donation_evaluation)
    end
  end

  def delete(conn, %{"id" => id}) do
    donation_evaluation = Logistic.get_donation_evaluation!(id)

    with {:ok, %Donation_evaluation{}} <- Logistic.delete_donation_evaluation(donation_evaluation) do
      send_resp(conn, :no_content, "")
    end
  end
end
