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
end
