defmodule AquebraWeb.DonorEntityController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.DonorEntity

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    donor_entities = Logistic.list_donorentities()
    render(conn, "index.json", donorentities: donor_entities)
  end

  def create(conn, %{"donor_entity" => donor_entity_params}) do
    with {:ok, %DonorEntity{} = donor_entity} <- Logistic.create_donor_entity(donor_entity_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.donor_entity_path(conn, :show, donor_entity))
      |> render("show.json", donor_entity: donor_entity)
    end
  end

  def show(conn, %{"id" => id}) do
    donor_entity = Logistic.get_donor_entity!(id)
    render(conn, "show.json", donor_entity: donor_entity)
  end

  def update(conn, %{"id" => id, "donor_entity" => donor_entity_params}) do
    donor_entity = Logistic.get_donor_entity!(id)

    with {:ok, %DonorEntity{} = donor_entity} <- Logistic.update_donor_entity(donor_entity, donor_entity_params) do
      render(conn, "show.json", donor_entity: donor_entity)
    end
  end

  def delete(conn, %{"id" => id}) do
    donor_entity = Logistic.get_donor_entity!(id)

    with {:ok, %DonorEntity{}} <- Logistic.delete_donor_entity(donor_entity) do
      send_resp(conn, :no_content, "")
    end
  end
end
