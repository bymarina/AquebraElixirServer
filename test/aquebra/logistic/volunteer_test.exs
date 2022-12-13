defmodule Aquebra.Logistic.VolunteerTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.Volunteer

  import Aquebra.LogisticFixtures

  @invalid_attrs %{name: nil, picture: nil, vehicleCapacity: nil}

  test "list_volunteers/0 returns all volunteers" do
    volunteer = volunteer_fixture()
    assert Logistic.list_volunteers() == [volunteer]
  end

  test "get_volunteer!/1 returns the volunteer with given id" do
    volunteer = volunteer_fixture()
    assert Logistic.get_volunteer!(volunteer.id) == volunteer
  end

  test "create_volunteer/1 with valid data creates a volunteer" do
    valid_attrs = %{name: "some name", picture: "some picture", vehicleCapacity: 42}

    assert {:ok, %Volunteer{} = volunteer} = Logistic.create_volunteer(valid_attrs)
    assert volunteer.name == "some name"
    assert volunteer.picture == "some picture"
    assert volunteer.vehicleCapacity == 42
  end

  test "create_volunteer/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_volunteer(@invalid_attrs)
  end

  test "update_volunteer/2 with valid data updates the volunteer" do
    volunteer = volunteer_fixture()
    update_attrs = %{name: "some updated name", picture: "some updated picture", vehicleCapacity: 43}

    assert {:ok, %Volunteer{} = volunteer} = Logistic.update_volunteer(volunteer, update_attrs)
    assert volunteer.name == "some updated name"
    assert volunteer.picture == "some updated picture"
    assert volunteer.vehicleCapacity == 43
  end

  test "update_volunteer/2 with invalid data returns error changeset" do
    volunteer = volunteer_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_volunteer(volunteer, @invalid_attrs)
    assert volunteer == Logistic.get_volunteer!(volunteer.id)
  end

  test "delete_volunteer/1 deletes the volunteer" do
    volunteer = volunteer_fixture()
    assert {:ok, %Volunteer{}} = Logistic.delete_volunteer(volunteer)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_volunteer!(volunteer.id) end
  end

  test "change_volunteer/1 returns a volunteer changeset" do
    volunteer = volunteer_fixture()
    assert %Ecto.Changeset{} = Logistic.change_volunteer(volunteer)
  end
end
