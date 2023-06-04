defmodule AquebraWeb.Donation_evaluationView do
  use AquebraWeb, :view
  alias AquebraWeb.Donation_evaluationView

  def render("index.json", %{donations_evaluation: donations_evaluation}) do
    %{data: render_many(donations_evaluation, Donation_evaluationView, "donation_evaluation.json")}
  end

  def render("show.json", %{donation_evaluation: donation_evaluation}) do
    %{data: render_one(donation_evaluation, Donation_evaluationView, "donation_evaluation.json")}
  end

  def render("donation_evaluation.json", %{donation_evaluation: donation_evaluation}) do
    %{
      id: donation_evaluation.id,
      total_available: donation_evaluation.total_available,
      total_donated: donation_evaluation.total_donated,
      match_ids: donation_evaluation.match_ids
    }
  end
end
