defmodule Aquebra.Logistic.NeededDonationTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.NeededDonation

  import Aquebra.LogisticFixtures

  @invalid_attrs %{day: nil, quantity: nil, type: nil}

  test "list_neededdonations/0 returns all neededdonations" do
    needed_donation = needed_donation_fixture()
    assert Logistic.list_neededdonations() == [needed_donation]
  end

  test "get_needed_donation!/1 returns the needed_donation with given id" do
    needed_donation = needed_donation_fixture()
    assert Logistic.get_needed_donation!(needed_donation.id) == needed_donation
  end

  test "create_needed_donation/1 with valid data creates a needed_donation" do
    valid_attrs = %{day: "some day", quantity: 42, type: "some type"}

    assert {:ok, %NeededDonation{} = needed_donation} = Logistic.create_needed_donation(valid_attrs)
    assert needed_donation.day == "some day"
    assert needed_donation.quantity == 42
    assert needed_donation.type == "some type"
  end

  test "create_needed_donation/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_needed_donation(@invalid_attrs)
  end

  test "update_needed_donation/2 with valid data updates the needed_donation" do
    needed_donation = needed_donation_fixture()
    update_attrs = %{day: "some updated day", quantity: 43, type: "some updated type"}

    assert {:ok, %NeededDonation{} = needed_donation} = Logistic.update_needed_donation(needed_donation, update_attrs)
    assert needed_donation.day == "some updated day"
    assert needed_donation.quantity == 43
    assert needed_donation.type == "some updated type"
  end

  test "update_needed_donation/2 with invalid data returns error changeset" do
    needed_donation = needed_donation_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_needed_donation(needed_donation, @invalid_attrs)
    assert needed_donation == Logistic.get_needed_donation!(needed_donation.id)
  end

  test "delete_needed_donation/1 deletes the needed_donation" do
    needed_donation = needed_donation_fixture()
    assert {:ok, %NeededDonation{}} = Logistic.delete_needed_donation(needed_donation)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_needed_donation!(needed_donation.id) end
  end

  test "change_needed_donation/1 returns a needed_donation changeset" do
    needed_donation = needed_donation_fixture()
    assert %Ecto.Changeset{} = Logistic.change_needed_donation(needed_donation)
  end
end
