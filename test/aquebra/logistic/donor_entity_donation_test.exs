defmodule Aquebra.Logistic.DonorEntityDonationTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.DonorEntityDonation

  import Aquebra.LogisticFixtures

  @invalid_attrs %{}

  test "list_donor_entity_donation/0 returns all donorentitydonation" do
    donor_entity = donor_entity_fixture()
    donation_product = donation_product_fixture()
    donor_entity_donation = donor_entity_donation_fixture(%{donorEntityId: donor_entity.id, donationId: donation_product.id})

    assert Logistic.list_donor_entity_donation() == [donor_entity_donation]
  end

  test "get_donor_entity_donation!/1 returns the donor_entity_donation with given id" do
    donor_entity = donor_entity_fixture()
    donation_product = donation_product_fixture()
    donor_entity_donation = donor_entity_donation_fixture(%{donorEntityId: donor_entity.id, donationId: donation_product.id})

    assert Logistic.get_donor_entity_donation!(donor_entity_donation.id) == donor_entity_donation
  end

  test "create_donor_entity_donation/1 with valid data creates a donor_entity_donation" do
    donor_entity = donor_entity_fixture()
    donation_product = donation_product_fixture()
    valid_attrs = %{donorEntityId: donor_entity.id, donationId: donation_product.id}

    assert {:ok, %DonorEntityDonation{} = donor_entity_donation} = Logistic.create_donor_entity_donation(valid_attrs)
  end

  test "create_donor_entity_donation/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_donor_entity_donation(@invalid_attrs)
  end

  test "update_donor_entity_donation/2 with valid data updates the donor_entity_donation" do
    donor_entity = donor_entity_fixture()
    donation_product = donation_product_fixture()
    donor_entity_donation = donor_entity_donation_fixture(%{donorEntityId: donor_entity.id, donationId: donation_product.id})
    donation_product_2 = donation_product_fixture()

    update_attrs = %{donationId: donation_product_2.id}

    assert {:ok, %DonorEntityDonation{} = donor_entity_donation} =
             Logistic.update_donor_entity_donation(donor_entity_donation, update_attrs)
  end

  test "update_donor_entity_donation/2 with invalid data returns error changeset" do
    donor_entity = donor_entity_fixture()
    donation_product = donation_product_fixture()
    donor_entity_donation = donor_entity_donation_fixture(%{donorEntityId: donor_entity.id, donationId: donation_product.id})

    assert {:error, %Ecto.Changeset{}} = Logistic.update_donor_entity_donation(donor_entity_donation, %{donationId: nil})
  end

  test "delete_donor_entity_donation/1 deletes the donor_entity_donation" do
    donor_entity = donor_entity_fixture()
    donation_product = donation_product_fixture()
    donor_entity_donation = donor_entity_donation_fixture(%{donorEntityId: donor_entity.id, donationId: donation_product.id})
    assert {:ok, %DonorEntityDonation{}} = Logistic.delete_donor_entity_donation(donor_entity_donation)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_donor_entity_donation!(donor_entity_donation.id) end
  end

  test "change_donor_entity_donation/1 returns a donor_entity_donation changeset" do
    donor_entity = donor_entity_fixture()
    donation_product = donation_product_fixture()
    donor_entity_donation = donor_entity_donation_fixture(%{donorEntityId: donor_entity.id, donationId: donation_product.id})
    assert %Ecto.Changeset{} = Logistic.change_donor_entity_donation(donor_entity_donation)
  end
end
