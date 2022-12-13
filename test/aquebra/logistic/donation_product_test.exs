defmodule Aquebra.Logistic.DonationProductTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.DonationProduct

  import Aquebra.LogisticFixtures

  @invalid_attrs %{day: nil, quantity: nil, type: nil}

  test "list_donationproducts/0 returns all donationproducts" do
    donation_product = donation_product_fixture()
    assert Logistic.list_donationproducts() == [donation_product]
  end

  test "get_donation_product!/1 returns the donation_product with given id" do
    donation_product = donation_product_fixture()
    assert Logistic.get_donation_product!(donation_product.id) == donation_product
  end

  test "create_donation_product/1 with valid data creates a donation_product" do
    valid_attrs = %{day: "some day", quantity: 42, type: "some type"}

    assert {:ok, %DonationProduct{} = donation_product} = Logistic.create_donation_product(valid_attrs)
    assert donation_product.day == "some day"
    assert donation_product.quantity == 42
    assert donation_product.type == "some type"
  end

  test "create_donation_product/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_donation_product(@invalid_attrs)
  end

  test "update_donation_product/2 with valid data updates the donation_product" do
    donation_product = donation_product_fixture()
    update_attrs = %{day: "some updated day", quantity: 43, type: "some updated type"}

    assert {:ok, %DonationProduct{} = donation_product} = Logistic.update_donation_product(donation_product, update_attrs)
    assert donation_product.day == "some updated day"
    assert donation_product.quantity == 43
    assert donation_product.type == "some updated type"
  end

  test "update_donation_product/2 with invalid data returns error changeset" do
    donation_product = donation_product_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_donation_product(donation_product, @invalid_attrs)
    assert donation_product == Logistic.get_donation_product!(donation_product.id)
  end

  test "delete_donation_product/1 deletes the donation_product" do
    donation_product = donation_product_fixture()
    assert {:ok, %DonationProduct{}} = Logistic.delete_donation_product(donation_product)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_donation_product!(donation_product.id) end
  end

  test "change_donation_product/1 returns a donation_product changeset" do
    donation_product = donation_product_fixture()
    assert %Ecto.Changeset{} = Logistic.change_donation_product(donation_product)
  end
end
