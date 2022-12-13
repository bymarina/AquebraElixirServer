defmodule AquebraWeb.DonorEntityDonationControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.DonorEntityDonation

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all donor_entity_donation", %{conn: conn} do
      conn = get(conn, Routes.donor_entity_donation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create donor_entity_donation" do
    test "renders donor_entity_donation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.donor_entity_donation_path(conn, :create), donor_entity_donation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.donor_entity_donation_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.donor_entity_donation_path(conn, :create), donor_entity_donation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update donor_entity_donation" do
    setup [:create_donor_entity_donation]

    test "renders donor_entity_donation when data is valid", %{
      conn: conn,
      donor_entity_donation: %DonorEntityDonation{id: id} = donor_entity_donation
    } do
      conn =
        put(conn, Routes.donor_entity_donation_path(conn, :update, donor_entity_donation),
          donor_entity_donation: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.donor_entity_donation_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, donor_entity_donation: donor_entity_donation} do
      conn =
        put(conn, Routes.donor_entity_donation_path(conn, :update, donor_entity_donation),
          donor_entity_donation: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete donor_entity_donation" do
    setup [:create_donor_entity_donation]

    test "deletes chosen donor_entity_donation", %{conn: conn, donor_entity_donation: donor_entity_donation} do
      conn = delete(conn, Routes.donor_entity_donation_path(conn, :delete, donor_entity_donation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.donor_entity_donation_path(conn, :show, donor_entity_donation))
      end
    end
  end

  defp create_donor_entity_donation(_) do
    donor_entity_donation = donor_entity_donation_fixture()
    %{donor_entity_donation: donor_entity_donation}
  end
end
