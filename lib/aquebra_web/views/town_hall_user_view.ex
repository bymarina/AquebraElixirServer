defmodule AquebraWeb.TownHallUserView do
  use AquebraWeb, :view
  alias AquebraWeb.TownHallUserView

  def render("index.json", %{townhallusers: townhallusers}) do
    %{data: render_many(townhallusers, TownHallUserView, "town_hall_user.json")}
  end

  def render("show.json", %{town_hall_user: town_hall_user}) do
    %{data: render_one(town_hall_user, TownHallUserView, "town_hall_user.json")}
  end

  def render("town_hall_user.json", %{town_hall_user: town_hall_user}) do
    %{
      id: town_hall_user.id,
      name: town_hall_user.name
    }
  end
end
