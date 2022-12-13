defmodule AquebraWeb.TownHallUserControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.TownHallUser

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all townhallusers", %{conn: conn} do
      conn = get(conn, Routes.town_hall_user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create town_hall_user" do
    test "renders town_hall_user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.town_hall_user_path(conn, :create), town_hall_user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.town_hall_user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.town_hall_user_path(conn, :create), town_hall_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update town_hall_user" do
    setup [:create_town_hall_user]

    test "renders town_hall_user when data is valid", %{conn: conn, town_hall_user: %TownHallUser{id: id} = town_hall_user} do
      conn = put(conn, Routes.town_hall_user_path(conn, :update, town_hall_user), town_hall_user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.town_hall_user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, town_hall_user: town_hall_user} do
      conn = put(conn, Routes.town_hall_user_path(conn, :update, town_hall_user), town_hall_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete town_hall_user" do
    setup [:create_town_hall_user]

    test "deletes chosen town_hall_user", %{conn: conn, town_hall_user: town_hall_user} do
      conn = delete(conn, Routes.town_hall_user_path(conn, :delete, town_hall_user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.town_hall_user_path(conn, :show, town_hall_user))
      end
    end
  end

  defp create_town_hall_user(_) do
    town_hall_user = town_hall_user_fixture()
    %{town_hall_user: town_hall_user}
  end
end
