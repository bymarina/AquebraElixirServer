defmodule AquebraWeb.DonorEntityControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.DonorEntity

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
    test "lists all donorentities", %{conn: conn} do
      conn = get(conn, Routes.donor_entity_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create donor_entity" do
    test "renders donor_entity when data is valid", %{conn: conn} do
      conn = post(conn, Routes.donor_entity_path(conn, :create), donor_entity: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.donor_entity_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "businessHoursClosing" => "some businessHoursClosing",
               "businessHoursOpening" => "some businessHoursOpening",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.donor_entity_path(conn, :create), donor_entity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update donor_entity" do
    setup [:create_donor_entity]

    test "renders donor_entity when data is valid", %{conn: conn, donor_entity: %DonorEntity{id: id} = donor_entity} do
      conn = put(conn, Routes.donor_entity_path(conn, :update, donor_entity), donor_entity: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.donor_entity_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "businessHoursClosing" => "some updated businessHoursClosing",
               "businessHoursOpening" => "some updated businessHoursOpening",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, donor_entity: donor_entity} do
      conn = put(conn, Routes.donor_entity_path(conn, :update, donor_entity), donor_entity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete donor_entity" do
    setup [:create_donor_entity]

    test "deletes chosen donor_entity", %{conn: conn, donor_entity: donor_entity} do
      conn = delete(conn, Routes.donor_entity_path(conn, :delete, donor_entity))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.donor_entity_path(conn, :show, donor_entity))
      end
    end
  end

  defp create_donor_entity(_) do
    donor_entity = donor_entity_fixture()
    %{donor_entity: donor_entity}
  end
end
