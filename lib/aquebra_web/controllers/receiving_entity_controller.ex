defmodule AquebraWeb.ReceivingEntityController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.ReceivingEntity

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    receivingentities = Logistic.list_receivingentities()
    render(conn, "index.json", receivingentities: receivingentities)
  end

  def create(conn, %{"receiving_entity" => receiving_entity_params}) do
    with {:ok, %ReceivingEntity{} = receiving_entity} <- Logistic.create_receiving_entity(receiving_entity_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.receiving_entity_path(conn, :show, receiving_entity))
      |> render("show.json", receiving_entity: receiving_entity)
    end
  end

  def show(conn, %{"id" => id}) do
    receiving_entity = Logistic.get_receiving_entity!(id)
    render(conn, "show.json", receiving_entity: receiving_entity)
  end

  def update(conn, %{"id" => id, "receiving_entity" => receiving_entity_params}) do
    receiving_entity = Logistic.get_receiving_entity!(id)

    with {:ok, %ReceivingEntity{} = receiving_entity} <-
           Logistic.update_receiving_entity(receiving_entity, receiving_entity_params) do
      render(conn, "show.json", receiving_entity: receiving_entity)
    end
  end

  def delete(conn, %{"id" => id}) do
    receiving_entity = Logistic.get_receiving_entity!(id)

    with {:ok, %ReceivingEntity{}} <- Logistic.delete_receiving_entity(receiving_entity) do
      send_resp(conn, :no_content, "")
    end
  end
end
