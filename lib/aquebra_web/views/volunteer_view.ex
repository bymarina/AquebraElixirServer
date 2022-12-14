defmodule AquebraWeb.VolunteerView do
  use AquebraWeb, :view
  alias AquebraWeb.VolunteerView

  def render("index.json", %{volunteers: volunteers}) do
    %{data: render_many(volunteers, VolunteerView, "volunteer.json")}
  end

  def render("show.json", %{volunteer: volunteer}) do
    %{volunteer: render_one(volunteer, VolunteerView, "volunteer.json")}
  end

  def render("volunteer.json", %{volunteer: volunteer}) do
    %{
      id: volunteer.id,
      name: volunteer.name,
      vehicleCapacity: volunteer.vehicleCapacity,
      picture: volunteer.picture
    }
  end
end
