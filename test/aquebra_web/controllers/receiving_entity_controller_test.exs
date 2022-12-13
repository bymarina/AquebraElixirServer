defmodule AquebraWeb.ReceivingEntityControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.ReceivingEntity

  @create_attrs %{
    businessHoursClosing: "some businessHoursClosing",
    businessHoursOpening: "some businessHoursOpening",
    name: "some name"
  }
  @update_attrs %{
    businessHoursClosing: "some updated businessHoursClosing",
    businessHoursOpening: "some updated businessHoursOpening",
    name: "some updated name"
  }
  @invalid_attrs %{businessHoursClosing: nil, businessHoursOpening: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all receivingentities", %{conn: conn} do
      conn = get(conn, Routes.receiving_entity_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create receiving_entity" do
    test "renders receiving_entity when data is valid", %{conn: conn} do
      conn = post(conn, Routes.receiving_entity_path(conn, :create), receiving_entity: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.receiving_entity_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "businessHoursClosing" => "some businessHoursClosing",
               "businessHoursOpening" => "some businessHoursOpening",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.receiving_entity_path(conn, :create), receiving_entity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update receiving_entity" do
    setup [:create_receiving_entity]

    test "renders receiving_entity when data is valid", %{
      conn: conn,
      receiving_entity: %ReceivingEntity{id: id} = receiving_entity
    } do
      conn = put(conn, Routes.receiving_entity_path(conn, :update, receiving_entity), receiving_entity: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.receiving_entity_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "businessHoursClosing" => "some updated businessHoursClosing",
               "businessHoursOpening" => "some updated businessHoursOpening",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, receiving_entity: receiving_entity} do
      conn = put(conn, Routes.receiving_entity_path(conn, :update, receiving_entity), receiving_entity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete receiving_entity" do
    setup [:create_receiving_entity]

    test "deletes chosen receiving_entity", %{conn: conn, receiving_entity: receiving_entity} do
      conn = delete(conn, Routes.receiving_entity_path(conn, :delete, receiving_entity))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.receiving_entity_path(conn, :show, receiving_entity))
      end
    end
  end

  defp create_receiving_entity(_) do
    receiving_entity = receiving_entity_fixture()
    %{receiving_entity: receiving_entity}
  end
end
