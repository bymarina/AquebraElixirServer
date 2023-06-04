defmodule AquebraWeb.Volunteer_evaluationView do
  use AquebraWeb, :view
  alias AquebraWeb.Volunteer_evaluationView

  def render("index.json", %{volunteers_evaluation: volunteers_evaluation}) do
    %{data: render_many(volunteers_evaluation, Volunteer_evaluationView, "volunteer_evaluation.json")}
  end

  def render("show.json", %{volunteer_evaluation: volunteer_evaluation}) do
    %{data: render_one(volunteer_evaluation, Volunteer_evaluationView, "volunteer_evaluation.json")}
  end

  def render("volunteer_evaluation.json", %{volunteer_evaluation: volunteer_evaluation}) do
    %{
      id: volunteer_evaluation.id,
      total_capacity: volunteer_evaluation.total_capacity,
      used_capacity: volunteer_evaluation.used_capacity,
      extra_distance: volunteer_evaluation.extra_distance,
      match_ids: volunteer_evaluation.match_ids
    }
  end
end
