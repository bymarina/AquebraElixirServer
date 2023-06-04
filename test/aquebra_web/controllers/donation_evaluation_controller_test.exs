defmodule AquebraWeb.Donation_evaluationControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.Donation_evaluation

  @create_attrs %{
    match_ids: "some match_ids",
    total_available: 120.5,
    total_donated: 120.5
  }
  @update_attrs %{
    match_ids: "some updated match_ids",
    total_available: 456.7,
    total_donated: 456.7
  }
  @invalid_attrs %{match_ids: nil, total_available: nil, total_donated: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all donations_evaluation", %{conn: conn} do
      conn = get(conn, Routes.donation_evaluation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create donation_evaluation" do
    test "renders donation_evaluation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.donation_evaluation_path(conn, :create), donation_evaluation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.donation_evaluation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "match_ids" => "some match_ids",
               "total_available" => 120.5,
               "total_donated" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.donation_evaluation_path(conn, :create), donation_evaluation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update donation_evaluation" do
    setup [:create_donation_evaluation]

    test "renders donation_evaluation when data is valid", %{
      conn: conn,
      donation_evaluation: %Donation_evaluation{id: id} = donation_evaluation
    } do
      conn =
        put(conn, Routes.donation_evaluation_path(conn, :update, donation_evaluation), donation_evaluation: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.donation_evaluation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "match_ids" => "some updated match_ids",
               "total_available" => 456.7,
               "total_donated" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, donation_evaluation: donation_evaluation} do
      conn =
        put(conn, Routes.donation_evaluation_path(conn, :update, donation_evaluation), donation_evaluation: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete donation_evaluation" do
    setup [:create_donation_evaluation]

    test "deletes chosen donation_evaluation", %{conn: conn, donation_evaluation: donation_evaluation} do
      conn = delete(conn, Routes.donation_evaluation_path(conn, :delete, donation_evaluation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.donation_evaluation_path(conn, :show, donation_evaluation))
      end
    end
  end

  defp create_donation_evaluation(_) do
    donation_evaluation = donation_evaluation_fixture()
    %{donation_evaluation: donation_evaluation}
  end
end
