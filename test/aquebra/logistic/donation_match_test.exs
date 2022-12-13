defmodule Aquebra.Logistic.DonationMatchTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.DonationMatch

  import Aquebra.LogisticFixtures

  @invalid_attrs %{donorEntityDonationId: nil}

  test "list_donationmatches/0 returns all donationmatches" do
    donation_donor_entity = donor_entity_donation_fixture()
    donation_needed_donation = needed_donation_fixture()
    donation_volunteer = volunteer_fixture()

    donation_match =
      donation_match_fixture(%{
        donorEntityDonationId: donation_donor_entity.id,
        neededDonationId: donation_needed_donation.id,
        volunteerId: donation_volunteer.id
      })

    assert Logistic.list_donationmatches() == [donation_match]
  end

  test "get_donation_match!/1 returns the donation_match with given id" do
    donation_donor_entity = donor_entity_donation_fixture()
    donation_needed_donation = needed_donation_fixture()
    donation_volunteer = volunteer_fixture()

    donation_match =
      donation_match_fixture(%{
        donorEntityDonationId: donation_donor_entity.id,
        neededDonationId: donation_needed_donation.id,
        volunteerId: donation_volunteer.id
      })

    assert Logistic.get_donation_match!(donation_match.id) == donation_match
  end

  test "create_donation_match/1 with valid data creates a donation_match" do
    donation_donor_entity = donor_entity_donation_fixture()
    donation_needed_donation = needed_donation_fixture()
    donation_volunteer = volunteer_fixture()

    valid_attrs = %{
      donorEntityDonationId: donation_donor_entity.id,
      neededDonationId: donation_needed_donation.id,
      volunteerId: donation_volunteer.id
    }

    assert {:ok, %DonationMatch{}} = Logistic.create_donation_match(valid_attrs)
  end

  test "create_donation_match/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_donation_match(@invalid_attrs)
  end

  test "update_donation_match/2 with valid data updates the donation_match" do
    donation_donor_entity = donor_entity_donation_fixture()
    donation_needed_donation = needed_donation_fixture()
    donation_volunteer = volunteer_fixture()

    donation_match =
      donation_match_fixture(%{
        donorEntityDonationId: donation_donor_entity.id,
        neededDonationId: donation_needed_donation.id,
        volunteerId: donation_volunteer.id
      })

    update_attrs = %{}

    assert {:ok, %DonationMatch{}} = Logistic.update_donation_match(donation_match, update_attrs)
  end

  test "update_donation_match/2 with invalid data returns error changeset" do
    donation_donor_entity = donor_entity_donation_fixture()
    donation_needed_donation = needed_donation_fixture()
    donation_volunteer = volunteer_fixture()

    donation_match =
      donation_match_fixture(%{
        donorEntityDonationId: donation_donor_entity.id,
        neededDonationId: donation_needed_donation.id,
        volunteerId: donation_volunteer.id
      })

    assert {:error, %Ecto.Changeset{}} = Logistic.update_donation_match(donation_match, @invalid_attrs)
    assert donation_match == Logistic.get_donation_match!(donation_match.id)
  end

  test "delete_donation_match/1 deletes the donation_match" do
    donation_donor_entity = donor_entity_donation_fixture()
    donation_needed_donation = needed_donation_fixture()
    donation_volunteer = volunteer_fixture()

    donation_match =
      donation_match_fixture(%{
        donorEntityDonationId: donation_donor_entity.id,
        neededDonationId: donation_needed_donation.id,
        volunteerId: donation_volunteer.id
      })

    assert {:ok, %DonationMatch{}} = Logistic.delete_donation_match(donation_match)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_donation_match!(donation_match.id) end
  end

  test "change_donation_match/1 returns a donation_match changeset" do
    donation_donor_entity = donor_entity_donation_fixture()
    donation_needed_donation = needed_donation_fixture()
    donation_volunteer = volunteer_fixture()

    donation_match =
      donation_match_fixture(%{
        donorEntityDonationId: donation_donor_entity.id,
        neededDonationId: donation_needed_donation.id,
        volunteerId: donation_volunteer.id
      })

    assert %Ecto.Changeset{} = Logistic.change_donation_match(donation_match)
  end
end
