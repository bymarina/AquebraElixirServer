defmodule AquebraWeb.Volunteer_evaluationControllerTest do
  use AquebraWeb.ConnCase

  import Aquebra.LogisticFixtures

  alias Aquebra.Logistic.Volunteer_evaluation

  @create_attrs %{
    extra_distance: 120.5,
    match_ids: "some match_ids",
    total_capacity: 120.5,
    used_capacity: 120.5
  }
  @update_attrs %{
    extra_distance: 456.7,
    match_ids: "some updated match_ids",
    total_capacity: 456.7,
    used_capacity: 456.7
  }
  @invalid_attrs %{extra_distance: nil, match_ids: nil, total_capacity: nil, used_capacity: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all volunteers_evaluation", %{conn: conn} do
      conn = get(conn, Routes.volunteer_evaluation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create volunteer_evaluation" do
    test "renders volunteer_evaluation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.volunteer_evaluation_path(conn, :create), volunteer_evaluation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.volunteer_evaluation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "extra_distance" => 120.5,
               "match_ids" => "some match_ids",
               "total_capacity" => 120.5,
               "used_capacity" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.volunteer_evaluation_path(conn, :create), volunteer_evaluation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update volunteer_evaluation" do
    setup [:create_volunteer_evaluation]

    test "renders volunteer_evaluation when data is valid", %{
      conn: conn,
      volunteer_evaluation: %Volunteer_evaluation{id: id} = volunteer_evaluation
    } do
      conn =
        put(conn, Routes.volunteer_evaluation_path(conn, :update, volunteer_evaluation), volunteer_evaluation: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.volunteer_evaluation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "extra_distance" => 456.7,
               "match_ids" => "some updated match_ids",
               "total_capacity" => 456.7,
               "used_capacity" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, volunteer_evaluation: volunteer_evaluation} do
      conn =
        put(conn, Routes.volunteer_evaluation_path(conn, :update, volunteer_evaluation), volunteer_evaluation: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete volunteer_evaluation" do
    setup [:create_volunteer_evaluation]

    test "deletes chosen volunteer_evaluation", %{conn: conn, volunteer_evaluation: volunteer_evaluation} do
      conn = delete(conn, Routes.volunteer_evaluation_path(conn, :delete, volunteer_evaluation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.volunteer_evaluation_path(conn, :show, volunteer_evaluation))
      end
    end
  end

  defp create_volunteer_evaluation(_) do
    volunteer_evaluation = volunteer_evaluation_fixture()
    %{volunteer_evaluation: volunteer_evaluation}
  end
end
