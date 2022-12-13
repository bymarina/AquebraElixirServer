defmodule Aquebra.Logistic.DocumentTest do
  use Aquebra.DataCase

  alias Aquebra.Logistic

  alias Aquebra.Logistic.Document

  import Aquebra.LogisticFixtures

  @invalid_attrs %{number: nil, type: nil}

  test "list_documents/0 returns all documents" do
    document = document_fixture()
    assert Logistic.list_documents() == [document]
  end

  test "get_document!/1 returns the document with given id" do
    document = document_fixture()
    assert Logistic.get_document!(document.id) == document
  end

  test "create_document/1 with valid data creates a document" do
    valid_attrs = %{number: "some number", type: "some type"}

    assert {:ok, %Document{} = document} = Logistic.create_document(valid_attrs)
    assert document.number == "some number"
    assert document.type == "some type"
  end

  test "create_document/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Logistic.create_document(@invalid_attrs)
  end

  test "update_document/2 with valid data updates the document" do
    document = document_fixture()
    update_attrs = %{number: "some updated number", type: "some updated type"}

    assert {:ok, %Document{} = document} = Logistic.update_document(document, update_attrs)
    assert document.number == "some updated number"
    assert document.type == "some updated type"
  end

  test "update_document/2 with invalid data returns error changeset" do
    document = document_fixture()
    assert {:error, %Ecto.Changeset{}} = Logistic.update_document(document, @invalid_attrs)
    assert document == Logistic.get_document!(document.id)
  end

  test "delete_document/1 deletes the document" do
    document = document_fixture()
    assert {:ok, %Document{}} = Logistic.delete_document(document)
    assert_raise Ecto.NoResultsError, fn -> Logistic.get_document!(document.id) end
  end

  test "change_document/1 returns a document changeset" do
    document = document_fixture()
    assert %Ecto.Changeset{} = Logistic.change_document(document)
  end
end
