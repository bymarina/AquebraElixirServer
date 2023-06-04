defmodule Aquebra.LogisticTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  describe "stocks" do
    alias Aquebra.Logistic.Stock

    import Aquebra.LogisticFixtures

    @invalid_attrs %{quantity: nil, type: nil}

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert Logistic.list_stocks() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Logistic.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      valid_attrs = %{quantity: 120.5, type: "some type"}

      assert {:ok, %Stock{} = stock} = Logistic.create_stock(valid_attrs)
      assert stock.quantity == 120.5
      assert stock.type == "some type"
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logistic.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{quantity: 456.7, type: "some updated type"}

      assert {:ok, %Stock{} = stock} = Logistic.update_stock(stock, update_attrs)
      assert stock.quantity == 456.7
      assert stock.type == "some updated type"
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Logistic.update_stock(stock, @invalid_attrs)
      assert stock == Logistic.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Logistic.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Logistic.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Logistic.change_stock(stock)
    end
  end

  describe "matches" do
    alias Aquebra.Logistic.Match

    import Aquebra.LogisticFixtures

    @invalid_attrs %{quantity: nil, type: nil}

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Logistic.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Logistic.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      valid_attrs = %{quantity: 120.5, type: "some type"}

      assert {:ok, %Match{} = match} = Logistic.create_match(valid_attrs)
      assert match.quantity == 120.5
      assert match.type == "some type"
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logistic.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      update_attrs = %{quantity: 456.7, type: "some updated type"}

      assert {:ok, %Match{} = match} = Logistic.update_match(match, update_attrs)
      assert match.quantity == 456.7
      assert match.type == "some updated type"
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Logistic.update_match(match, @invalid_attrs)
      assert match == Logistic.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Logistic.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Logistic.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Logistic.change_match(match)
    end
  end

  describe "donations" do
    alias Aquebra.Logistic.Donation

    import Aquebra.LogisticFixtures

    @invalid_attrs %{quantity: nil, type: nil}

    test "list_donations/0 returns all donations" do
      donation = donation_fixture()
      assert Logistic.list_donations() == [donation]
    end

    test "get_donation!/1 returns the donation with given id" do
      donation = donation_fixture()
      assert Logistic.get_donation!(donation.id) == donation
    end

    test "create_donation/1 with valid data creates a donation" do
      valid_attrs = %{quantity: 120.5, type: "some type"}

      assert {:ok, %Donation{} = donation} = Logistic.create_donation(valid_attrs)
      assert donation.quantity == 120.5
      assert donation.type == "some type"
    end

    test "create_donation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logistic.create_donation(@invalid_attrs)
    end

    test "update_donation/2 with valid data updates the donation" do
      donation = donation_fixture()
      update_attrs = %{quantity: 456.7, type: "some updated type"}

      assert {:ok, %Donation{} = donation} = Logistic.update_donation(donation, update_attrs)
      assert donation.quantity == 456.7
      assert donation.type == "some updated type"
    end

    test "update_donation/2 with invalid data returns error changeset" do
      donation = donation_fixture()
      assert {:error, %Ecto.Changeset{}} = Logistic.update_donation(donation, @invalid_attrs)
      assert donation == Logistic.get_donation!(donation.id)
    end

    test "delete_donation/1 deletes the donation" do
      donation = donation_fixture()
      assert {:ok, %Donation{}} = Logistic.delete_donation(donation)
      assert_raise Ecto.NoResultsError, fn -> Logistic.get_donation!(donation.id) end
    end

    test "change_donation/1 returns a donation changeset" do
      donation = donation_fixture()
      assert %Ecto.Changeset{} = Logistic.change_donation(donation)
    end
  end

  describe "demands_evaluation" do
    alias Aquebra.Logistic.Demand_evaluation

    import Aquebra.LogisticFixtures

    @invalid_attrs %{match_ids: nil, received_donation: nil, total_demand: nil}

    test "list_demands_evaluation/0 returns all demands_evaluation" do
      demand_evaluation = demand_evaluation_fixture()
      assert Logistic.list_demands_evaluation() == [demand_evaluation]
    end

    test "get_demand_evaluation!/1 returns the demand_evaluation with given id" do
      demand_evaluation = demand_evaluation_fixture()
      assert Logistic.get_demand_evaluation!(demand_evaluation.id) == demand_evaluation
    end

    test "create_demand_evaluation/1 with valid data creates a demand_evaluation" do
      valid_attrs = %{match_ids: "some match_ids", received_donation: 120.5, total_demand: 120.5}

      assert {:ok, %Demand_evaluation{} = demand_evaluation} = Logistic.create_demand_evaluation(valid_attrs)
      assert demand_evaluation.match_ids == "some match_ids"
      assert demand_evaluation.received_donation == 120.5
      assert demand_evaluation.total_demand == 120.5
    end

    test "create_demand_evaluation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logistic.create_demand_evaluation(@invalid_attrs)
    end

    test "update_demand_evaluation/2 with valid data updates the demand_evaluation" do
      demand_evaluation = demand_evaluation_fixture()
      update_attrs = %{match_ids: "some updated match_ids", received_donation: 456.7, total_demand: 456.7}

      assert {:ok, %Demand_evaluation{} = demand_evaluation} =
               Logistic.update_demand_evaluation(demand_evaluation, update_attrs)

      assert demand_evaluation.match_ids == "some updated match_ids"
      assert demand_evaluation.received_donation == 456.7
      assert demand_evaluation.total_demand == 456.7
    end

    test "update_demand_evaluation/2 with invalid data returns error changeset" do
      demand_evaluation = demand_evaluation_fixture()
      assert {:error, %Ecto.Changeset{}} = Logistic.update_demand_evaluation(demand_evaluation, @invalid_attrs)
      assert demand_evaluation == Logistic.get_demand_evaluation!(demand_evaluation.id)
    end

    test "delete_demand_evaluation/1 deletes the demand_evaluation" do
      demand_evaluation = demand_evaluation_fixture()
      assert {:ok, %Demand_evaluation{}} = Logistic.delete_demand_evaluation(demand_evaluation)
      assert_raise Ecto.NoResultsError, fn -> Logistic.get_demand_evaluation!(demand_evaluation.id) end
    end

    test "change_demand_evaluation/1 returns a demand_evaluation changeset" do
      demand_evaluation = demand_evaluation_fixture()
      assert %Ecto.Changeset{} = Logistic.change_demand_evaluation(demand_evaluation)
    end
  end

  describe "donations_evaluation" do
    alias Aquebra.Logistic.Donation_evaluation

    import Aquebra.LogisticFixtures

    @invalid_attrs %{match_ids: nil, total_available: nil, total_donated: nil}

    test "list_donations_evaluation/0 returns all donations_evaluation" do
      donation_evaluation = donation_evaluation_fixture()
      assert Logistic.list_donations_evaluation() == [donation_evaluation]
    end

    test "get_donation_evaluation!/1 returns the donation_evaluation with given id" do
      donation_evaluation = donation_evaluation_fixture()
      assert Logistic.get_donation_evaluation!(donation_evaluation.id) == donation_evaluation
    end

    test "create_donation_evaluation/1 with valid data creates a donation_evaluation" do
      valid_attrs = %{match_ids: "some match_ids", total_available: 120.5, total_donated: 120.5}

      assert {:ok, %Donation_evaluation{} = donation_evaluation} = Logistic.create_donation_evaluation(valid_attrs)
      assert donation_evaluation.match_ids == "some match_ids"
      assert donation_evaluation.total_available == 120.5
      assert donation_evaluation.total_donated == 120.5
    end

    test "create_donation_evaluation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logistic.create_donation_evaluation(@invalid_attrs)
    end

    test "update_donation_evaluation/2 with valid data updates the donation_evaluation" do
      donation_evaluation = donation_evaluation_fixture()
      update_attrs = %{match_ids: "some updated match_ids", total_available: 456.7, total_donated: 456.7}

      assert {:ok, %Donation_evaluation{} = donation_evaluation} =
               Logistic.update_donation_evaluation(donation_evaluation, update_attrs)

      assert donation_evaluation.match_ids == "some updated match_ids"
      assert donation_evaluation.total_available == 456.7
      assert donation_evaluation.total_donated == 456.7
    end

    test "update_donation_evaluation/2 with invalid data returns error changeset" do
      donation_evaluation = donation_evaluation_fixture()
      assert {:error, %Ecto.Changeset{}} = Logistic.update_donation_evaluation(donation_evaluation, @invalid_attrs)
      assert donation_evaluation == Logistic.get_donation_evaluation!(donation_evaluation.id)
    end

    test "delete_donation_evaluation/1 deletes the donation_evaluation" do
      donation_evaluation = donation_evaluation_fixture()
      assert {:ok, %Donation_evaluation{}} = Logistic.delete_donation_evaluation(donation_evaluation)
      assert_raise Ecto.NoResultsError, fn -> Logistic.get_donation_evaluation!(donation_evaluation.id) end
    end

    test "change_donation_evaluation/1 returns a donation_evaluation changeset" do
      donation_evaluation = donation_evaluation_fixture()
      assert %Ecto.Changeset{} = Logistic.change_donation_evaluation(donation_evaluation)
    end
  end

  describe "volunteers_evaluation" do
    alias Aquebra.Logistic.Volunteer_evaluation

    import Aquebra.LogisticFixtures

    @invalid_attrs %{extra_distance: nil, match_ids: nil, total_capacity: nil, used_capacity: nil}

    test "list_volunteers_evaluation/0 returns all volunteers_evaluation" do
      volunteer_evaluation = volunteer_evaluation_fixture()
      assert Logistic.list_volunteers_evaluation() == [volunteer_evaluation]
    end

    test "get_volunteer_evaluation!/1 returns the volunteer_evaluation with given id" do
      volunteer_evaluation = volunteer_evaluation_fixture()
      assert Logistic.get_volunteer_evaluation!(volunteer_evaluation.id) == volunteer_evaluation
    end

    test "create_volunteer_evaluation/1 with valid data creates a volunteer_evaluation" do
      valid_attrs = %{extra_distance: 120.5, match_ids: "some match_ids", total_capacity: 120.5, used_capacity: 120.5}

      assert {:ok, %Volunteer_evaluation{} = volunteer_evaluation} = Logistic.create_volunteer_evaluation(valid_attrs)
      assert volunteer_evaluation.extra_distance == 120.5
      assert volunteer_evaluation.match_ids == "some match_ids"
      assert volunteer_evaluation.total_capacity == 120.5
      assert volunteer_evaluation.used_capacity == 120.5
    end

    test "create_volunteer_evaluation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logistic.create_volunteer_evaluation(@invalid_attrs)
    end

    test "update_volunteer_evaluation/2 with valid data updates the volunteer_evaluation" do
      volunteer_evaluation = volunteer_evaluation_fixture()

      update_attrs = %{
        extra_distance: 456.7,
        match_ids: "some updated match_ids",
        total_capacity: 456.7,
        used_capacity: 456.7
      }

      assert {:ok, %Volunteer_evaluation{} = volunteer_evaluation} =
               Logistic.update_volunteer_evaluation(volunteer_evaluation, update_attrs)

      assert volunteer_evaluation.extra_distance == 456.7
      assert volunteer_evaluation.match_ids == "some updated match_ids"
      assert volunteer_evaluation.total_capacity == 456.7
      assert volunteer_evaluation.used_capacity == 456.7
    end

    test "update_volunteer_evaluation/2 with invalid data returns error changeset" do
      volunteer_evaluation = volunteer_evaluation_fixture()
      assert {:error, %Ecto.Changeset{}} = Logistic.update_volunteer_evaluation(volunteer_evaluation, @invalid_attrs)
      assert volunteer_evaluation == Logistic.get_volunteer_evaluation!(volunteer_evaluation.id)
    end

    test "delete_volunteer_evaluation/1 deletes the volunteer_evaluation" do
      volunteer_evaluation = volunteer_evaluation_fixture()
      assert {:ok, %Volunteer_evaluation{}} = Logistic.delete_volunteer_evaluation(volunteer_evaluation)
      assert_raise Ecto.NoResultsError, fn -> Logistic.get_volunteer_evaluation!(volunteer_evaluation.id) end
    end

    test "change_volunteer_evaluation/1 returns a volunteer_evaluation changeset" do
      volunteer_evaluation = volunteer_evaluation_fixture()
      assert %Ecto.Changeset{} = Logistic.change_volunteer_evaluation(volunteer_evaluation)
    end
  end
end
