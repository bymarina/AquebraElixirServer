defmodule Aquebra.Logistic.AddressTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.Address

  import Aquebra.LogisticFixtures

  @invalid_attrs %{cep: nil, complement: nil, coordinates: nil, number: nil, street: nil}

  test "list_addresses/0 returns all addresses" do
    address = address_fixture()
    assert Logistic.list_addresses() == [address]
  end

  test "get_address!/1 returns the address with given id" do
    address = address_fixture()
    assert Logistic.get_address!(address.id) == address
  end

  test "create_address/1 with valid data creates a address" do
    valid_attrs = %{
      cep: "some cep",
      complement: "some complement",
      coordinates: "some coordinates",
      number: 42,
      street: "some street"
    }

    assert {:ok, %Address{} = address} = Logistic.create_address(valid_attrs)
    assert address.cep == "some cep"
    assert address.complement == "some complement"
    assert address.coordinates == "some coordinates"
    assert address.number == 42
    assert address.street == "some street"
  end

  test "create_address/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_address(@invalid_attrs)
  end

  test "update_address/2 with valid data updates the address" do
    address = address_fixture()

    update_attrs = %{
      cep: "some updated cep",
      complement: "some updated complement",
      coordinates: "some updated coordinates",
      number: 43,
      street: "some updated street"
    }

    assert {:ok, %Address{} = address} = Logistic.update_address(address, update_attrs)
    assert address.cep == "some updated cep"
    assert address.complement == "some updated complement"
    assert address.coordinates == "some updated coordinates"
    assert address.number == 43
    assert address.street == "some updated street"
  end

  test "update_address/2 with invalid data returns error changeset" do
    address = address_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_address(address, @invalid_attrs)
    assert address == Logistic.get_address!(address.id)
  end

  test "delete_address/1 deletes the address" do
    address = address_fixture()
    assert {:ok, %Address{}} = Logistic.delete_address(address)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_address!(address.id) end
  end

  test "change_address/1 returns a address changeset" do
    address = address_fixture()
    assert %Ecto.Changeset{} = Logistic.change_address(address)
  end
end
