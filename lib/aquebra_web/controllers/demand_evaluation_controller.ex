defmodule AquebraWeb.Demand_evaluationController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.Demand_evaluation

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    demands_evaluation = Logistic.list_demands_evaluation()
    render(conn, "index.json", demands_evaluation: demands_evaluation)
  end

  def create(conn, %{"demand_evaluation" => demand_evaluation_params}) do
    with {:ok, %Demand_evaluation{} = demand_evaluation} <- Logistic.create_demand_evaluation(demand_evaluation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.demand_evaluation_path(conn, :show, demand_evaluation))
      |> render("show.json", demand_evaluation: demand_evaluation)
    end
  end

  def show(conn, %{"id" => id}) do
    demand_evaluation = Logistic.get_demand_evaluation!(id)
    render(conn, "show.json", demand_evaluation: demand_evaluation)
  end

  def update(conn, %{"id" => id, "demand_evaluation" => demand_evaluation_params}) do
    demand_evaluation = Logistic.get_demand_evaluation!(id)

    with {:ok, %Demand_evaluation{} = demand_evaluation} <-
           Logistic.update_demand_evaluation(demand_evaluation, demand_evaluation_params) do
      render(conn, "show.json", demand_evaluation: demand_evaluation)
    end
  end

  def delete(conn, %{"id" => id}) do
    demand_evaluation = Logistic.get_demand_evaluation!(id)

    with {:ok, %Demand_evaluation{}} <- Logistic.delete_demand_evaluation(demand_evaluation) do
      send_resp(conn, :no_content, "")
    end
  end
end
