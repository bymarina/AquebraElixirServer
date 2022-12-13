defmodule AquebraWeb.DonorEntityView do
  use AquebraWeb, :view
  alias AquebraWeb.DonorEntityView

  def render("index.json", %{donorentities: donorentities}) do
    %{data: render_many(donorentities, DonorEntityView, "donor_entity.json")}
  end

  def render("show.json", %{donor_entity: donor_entity}) do
    %{data: render_one(donor_entity, DonorEntityView, "donor_entity.json")}
  end

  def render("donor_entity.json", %{donor_entity: donor_entity}) do
    %{
      id: donor_entity.id,
      name: donor_entity.name,
      businessHoursOpening: donor_entity.businessHoursOpening,
      businessHoursClosing: donor_entity.businessHoursClosing
    }
  end
end
