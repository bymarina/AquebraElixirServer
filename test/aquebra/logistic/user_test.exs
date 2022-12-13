defmodule Aquebra.Logistic.UserTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.User

  import Aquebra.LogisticFixtures

  @invalid_attrs %{type: nil}

  test "list_users/0 returns all users" do
    user = user_fixture()
    assert Logistic.list_users() == [user]
  end

  test "get_user!/1 returns the user with given id" do
    user = user_fixture()
    assert Logistic.get_user!(user.id) == user
  end

  test "create_user/1 with valid data creates a user" do
    valid_attrs = %{type: "some type"}

    assert {:ok, %User{} = user} = Logistic.create_user(valid_attrs)
    assert user.type == "some type"
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = user_fixture()
    update_attrs = %{type: "some updated type"}

    assert {:ok, %User{} = user} = Logistic.update_user(user, update_attrs)
    assert user.type == "some updated type"
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = user_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_user(user, @invalid_attrs)
    assert user == Logistic.get_user!(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = user_fixture()
    assert {:ok, %User{}} = Logistic.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = user_fixture()
    assert %Ecto.Changeset{} = Logistic.change_user(user)
  end
end
