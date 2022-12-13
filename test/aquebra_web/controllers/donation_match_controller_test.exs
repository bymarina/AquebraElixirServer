defmodule AquebraWeb.DonationMatchControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.DonationMatch

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all donationmatches", %{conn: conn} do
      conn = get(conn, Routes.donation_match_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create donation_match" do
    test "renders donation_match when data is valid", %{conn: conn} do
      conn = post(conn, Routes.donation_match_path(conn, :create), donation_match: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.donation_match_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.donation_match_path(conn, :create), donation_match: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update donation_match" do
    setup [:create_donation_match]

    test "renders donation_match when data is valid", %{conn: conn, donation_match: %DonationMatch{id: id} = donation_match} do
      conn = put(conn, Routes.donation_match_path(conn, :update, donation_match), donation_match: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.donation_match_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, donation_match: donation_match} do
      conn = put(conn, Routes.donation_match_path(conn, :update, donation_match), donation_match: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete donation_match" do
    setup [:create_donation_match]

    test "deletes chosen donation_match", %{conn: conn, donation_match: donation_match} do
      conn = delete(conn, Routes.donation_match_path(conn, :delete, donation_match))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.donation_match_path(conn, :show, donation_match))
      end
    end
  end

  defp create_donation_match(_) do
    donation_match = donation_match_fixture()
    %{donation_match: donation_match}
  end
end
