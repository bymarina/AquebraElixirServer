defmodule AquebraWeb.DonationControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.Donation

  @create_attrs %{
    quantity: 120.5,
    type: "some type"
  }
  @update_attrs %{
    quantity: 456.7,
    type: "some updated type"
  }
  @invalid_attrs %{quantity: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all donations", %{conn: conn} do
      conn = get(conn, Routes.donation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create donation" do
    test "renders donation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.donation_path(conn, :create), donation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.donation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "quantity" => 120.5,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.donation_path(conn, :create), donation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update donation" do
    setup [:create_donation]

    test "renders donation when data is valid", %{conn: conn, donation: %Donation{id: id} = donation} do
      conn = put(conn, Routes.donation_path(conn, :update, donation), donation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.donation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "quantity" => 456.7,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, donation: donation} do
      conn = put(conn, Routes.donation_path(conn, :update, donation), donation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete donation" do
    setup [:create_donation]

    test "deletes chosen donation", %{conn: conn, donation: donation} do
      conn = delete(conn, Routes.donation_path(conn, :delete, donation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.donation_path(conn, :show, donation))
      end
    end
  end

  defp create_donation(_) do
    donation = donation_fixture()
    %{donation: donation}
  end
end
