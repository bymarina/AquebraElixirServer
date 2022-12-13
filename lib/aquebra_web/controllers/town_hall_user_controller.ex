defmodule AquebraWeb.TownHallUserController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.TownHallUser

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    townhallusers = Logistic.list_townhallusers()
    render(conn, "index.json", townhallusers: townhallusers)
  end

  def create(conn, %{"town_hall_user" => town_hall_user_params}) do
    with {:ok, %TownHallUser{} = town_hall_user} <- Logistic.create_town_hall_user(town_hall_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.town_hall_user_path(conn, :show, town_hall_user))
      |> render("show.json", town_hall_user: town_hall_user)
    end
  end

  def show(conn, %{"id" => id}) do
    town_hall_user = Logistic.get_town_hall_user!(id)
    render(conn, "show.json", town_hall_user: town_hall_user)
  end

  def update(conn, %{"id" => id, "town_hall_user" => town_hall_user_params}) do
    town_hall_user = Logistic.get_town_hall_user!(id)

    with {:ok, %TownHallUser{} = town_hall_user} <- Logistic.update_town_hall_user(town_hall_user, town_hall_user_params) do
      render(conn, "show.json", town_hall_user: town_hall_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    town_hall_user = Logistic.get_town_hall_user!(id)

    with {:ok, %TownHallUser{}} <- Logistic.delete_town_hall_user(town_hall_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
