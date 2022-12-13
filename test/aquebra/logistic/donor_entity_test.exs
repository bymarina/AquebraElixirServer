defmodule Aquebra.Logistic.DonorEntityTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.DonorEntity

  import Aquebra.LogisticFixtures

  @invalid_attrs %{businessHoursClosing: nil, businessHoursOpening: nil, name: nil}

  test "list_donorentities/0 returns all donorentities" do
    donor_entity = donor_entity_fixture()
    assert Logistic.list_donorentities() == [donor_entity]
  end

  test "get_donor_entity!/1 returns the donor_entity with given id" do
    donor_entity = donor_entity_fixture()
    assert Logistic.get_donor_entity!(donor_entity.id) == donor_entity
  end

  test "create_donor_entity/1 with valid data creates a donor_entity" do
    valid_attrs = %{
      businessHoursClosing: "some businessHoursClosing",
      businessHoursOpening: "some businessHoursOpening",
      name: "some name"
    }

    assert {:ok, %DonorEntity{} = donor_entity} = Logistic.create_donor_entity(valid_attrs)
    assert donor_entity.businessHoursClosing == "some businessHoursClosing"
    assert donor_entity.businessHoursOpening == "some businessHoursOpening"
    assert donor_entity.name == "some name"
  end

  test "create_donor_entity/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_donor_entity(@invalid_attrs)
  end

  test "update_donor_entity/2 with valid data updates the donor_entity" do
    donor_entity = donor_entity_fixture()

    update_attrs = %{
      businessHoursClosing: "some updated businessHoursClosing",
      businessHoursOpening: "some updated businessHoursOpening",
      name: "some updated name"
    }

    assert {:ok, %DonorEntity{} = donor_entity} = Logistic.update_donor_entity(donor_entity, update_attrs)
    assert donor_entity.businessHoursClosing == "some updated businessHoursClosing"
    assert donor_entity.businessHoursOpening == "some updated businessHoursOpening"
    assert donor_entity.name == "some updated name"
  end

  test "update_donor_entity/2 with invalid data returns error changeset" do
    donor_entity = donor_entity_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_donor_entity(donor_entity, @invalid_attrs)
    assert donor_entity == Logistic.get_donor_entity!(donor_entity.id)
  end

  test "delete_donor_entity/1 deletes the donor_entity" do
    donor_entity = donor_entity_fixture()
    assert {:ok, %DonorEntity{}} = Logistic.delete_donor_entity(donor_entity)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_donor_entity!(donor_entity.id) end
  end

  test "change_donor_entity/1 returns a donor_entity changeset" do
    donor_entity = donor_entity_fixture()
    assert %Ecto.Changeset{} = Logistic.change_donor_entity(donor_entity)
  end
end
