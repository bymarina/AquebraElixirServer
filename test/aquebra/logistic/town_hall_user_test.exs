defmodule Aquebra.Logistic.TownHallUserTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.TownHallUser

  import Aquebra.LogisticFixtures

  @invalid_attrs %{name: nil}

  test "list_townhallusers/0 returns all townhallusers" do
    town_hall_user = town_hall_user_fixture()
    assert Logistic.list_townhallusers() == [town_hall_user]
  end

  test "get_town_hall_user!/1 returns the town_hall_user with given id" do
    town_hall_user = town_hall_user_fixture()
    assert Logistic.get_town_hall_user!(town_hall_user.id) == town_hall_user
  end

  test "create_town_hall_user/1 with valid data creates a town_hall_user" do
    valid_attrs = %{name: "some name"}

    assert {:ok, %TownHallUser{} = town_hall_user} = Logistic.create_town_hall_user(valid_attrs)
    assert town_hall_user.name == "some name"
  end

  test "create_town_hall_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_town_hall_user(@invalid_attrs)
  end

  test "update_town_hall_user/2 with valid data updates the town_hall_user" do
    town_hall_user = town_hall_user_fixture()
    update_attrs = %{name: "some updated name"}

    assert {:ok, %TownHallUser{} = town_hall_user} = Logistic.update_town_hall_user(town_hall_user, update_attrs)
    assert town_hall_user.name == "some updated name"
  end

  test "update_town_hall_user/2 with invalid data returns error changeset" do
    town_hall_user = town_hall_user_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_town_hall_user(town_hall_user, @invalid_attrs)
    assert town_hall_user == Logistic.get_town_hall_user!(town_hall_user.id)
  end

  test "delete_town_hall_user/1 deletes the town_hall_user" do
    town_hall_user = town_hall_user_fixture()
    assert {:ok, %TownHallUser{}} = Logistic.delete_town_hall_user(town_hall_user)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_town_hall_user!(town_hall_user.id) end
  end

  test "change_town_hall_user/1 returns a town_hall_user changeset" do
    town_hall_user = town_hall_user_fixture()
    assert %Ecto.Changeset{} = Logistic.change_town_hall_user(town_hall_user)
  end
end
