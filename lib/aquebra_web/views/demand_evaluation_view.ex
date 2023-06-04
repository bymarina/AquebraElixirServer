defmodule AquebraWeb.Demand_evaluationView do
  use AquebraWeb, :view
  alias AquebraWeb.Demand_evaluationView

  def render("index.json", %{demands_evaluation: demands_evaluation}) do
    %{data: render_many(demands_evaluation, Demand_evaluationView, "demand_evaluation.json")}
  end

  def render("show.json", %{demand_evaluation: demand_evaluation}) do
    %{data: render_one(demand_evaluation, Demand_evaluationView, "demand_evaluation.json")}
  end

  def render("demand_evaluation.json", %{demand_evaluation: demand_evaluation}) do
    %{
      id: demand_evaluation.id,
      total_demand: demand_evaluation.total_demand,
      received_donation: demand_evaluation.received_donation,
      match_ids: demand_evaluation.match_ids
    }
  end
end
