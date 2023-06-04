defmodule AquebraWeb.Volunteer_evaluationController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.Volunteer_evaluation

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    volunteers_evaluation = Logistic.list_volunteers_evaluation()
    render(conn, "index.json", volunteers_evaluation: volunteers_evaluation)
  end

  def create(conn, %{"volunteer_evaluation" => volunteer_evaluation_params}) do
    with {:ok, %Volunteer_evaluation{} = volunteer_evaluation} <-
           Logistic.create_volunteer_evaluation(volunteer_evaluation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.volunteer_evaluation_path(conn, :show, volunteer_evaluation))
      |> render("show.json", volunteer_evaluation: volunteer_evaluation)
    end
  end

  def show(conn, %{"id" => id}) do
    volunteer_evaluation = Logistic.get_volunteer_evaluation!(id)
    render(conn, "show.json", volunteer_evaluation: volunteer_evaluation)
  end

  def update(conn, %{"id" => id, "volunteer_evaluation" => volunteer_evaluation_params}) do
    volunteer_evaluation = Logistic.get_volunteer_evaluation!(id)

    with {:ok, %Volunteer_evaluation{} = volunteer_evaluation} <-
           Logistic.update_volunteer_evaluation(volunteer_evaluation, volunteer_evaluation_params) do
      render(conn, "show.json", volunteer_evaluation: volunteer_evaluation)
    end
  end

  def delete(conn, %{"id" => id}) do
    volunteer_evaluation = Logistic.get_volunteer_evaluation!(id)

    with {:ok, %Volunteer_evaluation{}} <- Logistic.delete_volunteer_evaluation(volunteer_evaluation) do
      send_resp(conn, :no_content, "")
    end
  end
end
