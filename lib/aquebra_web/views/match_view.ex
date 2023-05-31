defmodule AquebraWeb.MatchView do
  use AquebraWeb, :view
  alias AquebraWeb.MatchView

  def render("index.json", %{matches: matches}) do
    %{data: render_many(matches, MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{data: render_one(match, MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{
      id: match.id,
      type: match.type,
      quantity: match.quantity
    }
  end
end
