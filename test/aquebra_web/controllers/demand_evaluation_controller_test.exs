defmodule AquebraWeb.Demand_evaluationControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.Demand_evaluation

  @create_attrs %{
    match_ids: "some match_ids",
    received_donation: 120.5,
    total_demand: 120.5
  }
  @update_attrs %{
    match_ids: "some updated match_ids",
    received_donation: 456.7,
    total_demand: 456.7
  }
  @invalid_attrs %{match_ids: nil, received_donation: nil, total_demand: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all demands_evaluation", %{conn: conn} do
      conn = get(conn, Routes.demand_evaluation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create demand_evaluation" do
    test "renders demand_evaluation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.demand_evaluation_path(conn, :create), demand_evaluation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.demand_evaluation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "match_ids" => "some match_ids",
               "received_donation" => 120.5,
               "total_demand" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.demand_evaluation_path(conn, :create), demand_evaluation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update demand_evaluation" do
    setup [:create_demand_evaluation]

    test "renders demand_evaluation when data is valid", %{
      conn: conn,
      demand_evaluation: %Demand_evaluation{id: id} = demand_evaluation
    } do
      conn = put(conn, Routes.demand_evaluation_path(conn, :update, demand_evaluation), demand_evaluation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.demand_evaluation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "match_ids" => "some updated match_ids",
               "received_donation" => 456.7,
               "total_demand" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, demand_evaluation: demand_evaluation} do
      conn = put(conn, Routes.demand_evaluation_path(conn, :update, demand_evaluation), demand_evaluation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete demand_evaluation" do
    setup [:create_demand_evaluation]

    test "deletes chosen demand_evaluation", %{conn: conn, demand_evaluation: demand_evaluation} do
      conn = delete(conn, Routes.demand_evaluation_path(conn, :delete, demand_evaluation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.demand_evaluation_path(conn, :show, demand_evaluation))
      end
    end
  end

  defp create_demand_evaluation(_) do
    demand_evaluation = demand_evaluation_fixture()
    %{demand_evaluation: demand_evaluation}
  end
end
