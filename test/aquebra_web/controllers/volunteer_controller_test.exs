defmodule AquebraWeb.VolunteerControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.Volunteer

  @create_attrs %{
    name: "some name",
    picture: "some picture",
    vehicleCapacity: 42
  }
  @update_attrs %{
    name: "some updated name",
    picture: "some updated picture",
    vehicleCapacity: 43
  }
  @invalid_attrs %{name: nil, picture: nil, vehicleCapacity: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all volunteers", %{conn: conn} do
      conn = get(conn, Routes.volunteer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create volunteer" do
    test "renders volunteer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.volunteer_path(conn, :create), volunteer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.volunteer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "picture" => "some picture",
               "vehicleCapacity" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.volunteer_path(conn, :create), volunteer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update volunteer" do
    setup [:create_volunteer]

    test "renders volunteer when data is valid", %{conn: conn, volunteer: %Volunteer{id: id} = volunteer} do
      conn = put(conn, Routes.volunteer_path(conn, :update, volunteer), volunteer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.volunteer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "picture" => "some updated picture",
               "vehicleCapacity" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, volunteer: volunteer} do
      conn = put(conn, Routes.volunteer_path(conn, :update, volunteer), volunteer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete volunteer" do
    setup [:create_volunteer]

    test "deletes chosen volunteer", %{conn: conn, volunteer: volunteer} do
      conn = delete(conn, Routes.volunteer_path(conn, :delete, volunteer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.volunteer_path(conn, :show, volunteer))
      end
    end
  end

  defp create_volunteer(_) do
    volunteer = volunteer_fixture()
    %{volunteer: volunteer}
  end
end
