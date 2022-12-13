defmodule AquebraWeb.ReceivingEntityView do
  use AquebraWeb, :view
  alias AquebraWeb.ReceivingEntityView

  def render("index.json", %{receivingentities: receivingentities}) do
    %{data: render_many(receivingentities, ReceivingEntityView, "receiving_entity.json")}
  end

  def render("show.json", %{receiving_entity: receiving_entity}) do
    %{data: render_one(receiving_entity, ReceivingEntityView, "receiving_entity.json")}
  end

  def render("receiving_entity.json", %{receiving_entity: receiving_entity}) do
    %{
      id: receiving_entity.id,
      name: receiving_entity.name,
      businessHoursOpening: receiving_entity.businessHoursOpening,
      businessHoursClosing: receiving_entity.businessHoursClosing
    }
  end
end
