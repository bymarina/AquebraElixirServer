defmodule AquebraWeb.NeededDonationControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.NeededDonation

  @create_attrs %{
    day: "some day",
    quantity: 42,
    type: "some type"
  }
  @update_attrs %{
    day: "some updated day",
    quantity: 43,
    type: "some updated type"
  }
  @invalid_attrs %{day: nil, quantity: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all neededdonations", %{conn: conn} do
      conn = get(conn, Routes.needed_donation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create needed_donation" do
    test "renders needed_donation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.needed_donation_path(conn, :create), needed_donation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.needed_donation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "some day",
               "quantity" => 42,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.needed_donation_path(conn, :create), needed_donation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update needed_donation" do
    setup [:create_needed_donation]

    test "renders needed_donation when data is valid", %{
      conn: conn,
      needed_donation: %NeededDonation{id: id} = needed_donation
    } do
      conn = put(conn, Routes.needed_donation_path(conn, :update, needed_donation), needed_donation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.needed_donation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "some updated day",
               "quantity" => 43,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, needed_donation: needed_donation} do
      conn = put(conn, Routes.needed_donation_path(conn, :update, needed_donation), needed_donation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete needed_donation" do
    setup [:create_needed_donation]

    test "deletes chosen needed_donation", %{conn: conn, needed_donation: needed_donation} do
      conn = delete(conn, Routes.needed_donation_path(conn, :delete, needed_donation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.needed_donation_path(conn, :show, needed_donation))
      end
    end
  end

  defp create_needed_donation(_) do
    needed_donation = needed_donation_fixture()
    %{needed_donation: needed_donation}
  end
end
