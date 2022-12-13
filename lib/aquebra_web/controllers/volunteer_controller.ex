defmodule AquebraWeb.VolunteerController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.Volunteer

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    volunteers = Logistic.list_volunteers()
    render(conn, "index.json", volunteers: volunteers)
  end

  def create(conn, %{"volunteer" => volunteer_params}) do
    with {:ok, %Volunteer{} = volunteer} <- Logistic.create_volunteer(volunteer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.volunteer_path(conn, :show, volunteer))
      |> render("show.json", volunteer: volunteer)
    end
  end

  def show(conn, %{"id" => id}) do
    volunteer = Logistic.get_volunteer!(id)
    render(conn, "show.json", volunteer: volunteer)
  end

  def update(conn, %{"id" => id, "volunteer" => volunteer_params}) do
    volunteer = Logistic.get_volunteer!(id)

    with {:ok, %Volunteer{} = volunteer} <- Logistic.update_volunteer(volunteer, volunteer_params) do
      render(conn, "show.json", volunteer: volunteer)
    end
  end

  def delete(conn, %{"id" => id}) do
    volunteer = Logistic.get_volunteer!(id)

    with {:ok, %Volunteer{}} <- Logistic.delete_volunteer(volunteer) do
      send_resp(conn, :no_content, "")
    end
  end
end
