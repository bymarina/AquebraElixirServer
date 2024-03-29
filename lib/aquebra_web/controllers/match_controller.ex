defmodule AquebraWeb.MatchController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.Match

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    matches = Logistic.list_matches()
    render(conn, "index.json", matches: matches)
  end

  def create(conn, %{"match" => match_params}) do
    with {:ok, %Match{} = match} <- Logistic.create_match(match_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.match_path(conn, :show, match))
      |> render("show.json", match: match)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Logistic.get_match!(id)
    render(conn, "show.json", match: match)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Logistic.get_match!(id)

    with {:ok, %Match{} = match} <- Logistic.update_match(match, match_params) do
      render(conn, "show.json", match: match)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Logistic.get_match!(id)

    with {:ok, %Match{}} <- Logistic.delete_match(match) do
      send_resp(conn, :no_content, "")
    end
  end
end
