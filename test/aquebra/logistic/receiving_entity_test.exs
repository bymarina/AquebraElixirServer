defmodule Aquebra.Logistic.ReceivingEntityTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.ReceivingEntity

  import Aquebra.LogisticFixtures

  @invalid_attrs %{businessHoursClosing: nil, businessHoursOpening: nil, name: nil}

  test "list_receivingentities/0 returns all receivingentities" do
    receiving_entity = receiving_entity_fixture()
    assert Logistic.list_receivingentities() == [receiving_entity]
  end

  test "get_receiving_entity!/1 returns the receiving_entity with given id" do
    receiving_entity = receiving_entity_fixture()
    assert Logistic.get_receiving_entity!(receiving_entity.id) == receiving_entity
  end

  test "create_receiving_entity/1 with valid data creates a receiving_entity" do
    valid_attrs = %{
      businessHoursClosing: "some businessHoursClosing",
      businessHoursOpening: "some businessHoursOpening",
      name: "some name"
    }

    assert {:ok, %ReceivingEntity{} = receiving_entity} = Logistic.create_receiving_entity(valid_attrs)
    assert receiving_entity.businessHoursClosing == "some businessHoursClosing"
    assert receiving_entity.businessHoursOpening == "some businessHoursOpening"
    assert receiving_entity.name == "some name"
  end

  test "create_receiving_entity/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_receiving_entity(@invalid_attrs)
  end

  test "update_receiving_entity/2 with valid data updates the receiving_entity" do
    receiving_entity = receiving_entity_fixture()

    update_attrs = %{
      businessHoursClosing: "some updated businessHoursClosing",
      businessHoursOpening: "some updated businessHoursOpening",
      name: "some updated name"
    }

    assert {:ok, %ReceivingEntity{} = receiving_entity} = Logistic.update_receiving_entity(receiving_entity, update_attrs)
    assert receiving_entity.businessHoursClosing == "some updated businessHoursClosing"
    assert receiving_entity.businessHoursOpening == "some updated businessHoursOpening"
    assert receiving_entity.name == "some updated name"
  end

  test "update_receiving_entity/2 with invalid data returns error changeset" do
    receiving_entity = receiving_entity_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_receiving_entity(receiving_entity, @invalid_attrs)
    assert receiving_entity == Logistic.get_receiving_entity!(receiving_entity.id)
  end

  test "delete_receiving_entity/1 deletes the receiving_entity" do
    receiving_entity = receiving_entity_fixture()
    assert {:ok, %ReceivingEntity{}} = Logistic.delete_receiving_entity(receiving_entity)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_receiving_entity!(receiving_entity.id) end
  end

  test "change_receiving_entity/1 returns a receiving_entity changeset" do
    receiving_entity = receiving_entity_fixture()
    assert %Ecto.Changeset{} = Logistic.change_receiving_entity(receiving_entity)
  end
end
