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
end
