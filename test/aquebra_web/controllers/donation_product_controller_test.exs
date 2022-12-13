defmodule AquebraWeb.DonationProductControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.DonationProduct

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
    test "lists all donationproducts", %{conn: conn} do
      conn = get(conn, Routes.donation_product_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create donation_product" do
    test "renders donation_product when data is valid", %{conn: conn} do
      conn = post(conn, Routes.donation_product_path(conn, :create), donation_product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.donation_product_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "some day",
               "quantity" => 42,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.donation_product_path(conn, :create), donation_product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update donation_product" do
    setup [:create_donation_product]

    test "renders donation_product when data is valid", %{
      conn: conn,
      donation_product: %DonationProduct{id: id} = donation_product
    } do
      conn = put(conn, Routes.donation_product_path(conn, :update, donation_product), donation_product: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.donation_product_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "some updated day",
               "quantity" => 43,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, donation_product: donation_product} do
      conn = put(conn, Routes.donation_product_path(conn, :update, donation_product), donation_product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete donation_product" do
    setup [:create_donation_product]

    test "deletes chosen donation_product", %{conn: conn, donation_product: donation_product} do
      conn = delete(conn, Routes.donation_product_path(conn, :delete, donation_product))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.donation_product_path(conn, :show, donation_product))
      end
    end
  end

  defp create_donation_product(_) do
    donation_product = donation_product_fixture()
    %{donation_product: donation_product}
  end
end
