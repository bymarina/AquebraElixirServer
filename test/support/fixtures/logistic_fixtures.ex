defmodule Aquebra.LogisticFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Aquebra.Logistic` context.
  """

  @doc """
  Generate a document.
  """
  def document_fixture(attrs \\ %{}) do
    {:ok, document} =
      attrs
      |> Enum.into(%{
        number: "some number",
        type: "some type"
      })
      |> Aquebra.Logistic.create_document()

    document
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        type: "some type",
        firebaseId: "FAKE ID"
      })
      |> Aquebra.Logistic.create_user()

    user
  end

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        cep: "some cep",
        complement: "some complement",
        coordinates: "some coordinates",
        number: 42,
        street: "some street"
      })
      |> Aquebra.Logistic.create_address()

    address
  end

  @doc """
  Generate a donation_product.
  """
  def donation_product_fixture(attrs \\ %{}) do
    {:ok, donation_product} =
      attrs
      |> Enum.into(%{
        day: "some day",
        quantity: 42,
        type: "some type"
      })
      |> Aquebra.Logistic.create_donation_product()

    donation_product
  end

  @doc """
  Generate a needed_donation.
  """
  def needed_donation_fixture(attrs \\ %{}) do
    {:ok, needed_donation} =
      attrs
      |> Enum.into(%{
        day: "some day",
        quantity: 42,
        type: "some type"
      })
      |> Aquebra.Logistic.create_needed_donation()

    needed_donation
  end

  @doc """
  Generate a receiving_entity.
  """
  def receiving_entity_fixture(attrs \\ %{}) do
    {:ok, receiving_entity} =
      attrs
      |> Enum.into(%{
        businessHoursClosing: "some businessHoursClosing",
        businessHoursOpening: "some businessHoursOpening",
        name: "some name"
      })
      |> Aquebra.Logistic.create_receiving_entity()

    receiving_entity
  end

  @doc """
  Generate a donor_entity.
  """
  def donor_entity_fixture(attrs \\ %{}) do
    {:ok, donor_entity} =
      attrs
      |> Enum.into(%{
        businessHoursClosing: "some businessHoursClosing",
        businessHoursOpening: "some businessHoursOpening",
        name: "some name"
      })
      |> Aquebra.Logistic.create_donor_entity()

    donor_entity
  end

  @doc """
  Generate a volunteer.
  """
  def volunteer_fixture(attrs \\ %{}) do
    {:ok, volunteer} =
      attrs
      |> Enum.into(%{
        name: "some name",
        picture: "some picture",
        vehicleCapacity: 42
      })
      |> Aquebra.Logistic.create_volunteer()

    volunteer
  end

  @doc """
  Generate a town_hall_user.
  """
  def town_hall_user_fixture(attrs \\ %{}) do
    {:ok, town_hall_user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Aquebra.Logistic.create_town_hall_user()

    town_hall_user
  end

  @doc """
  Generate a donor_entity_donation.
  """
  def donor_entity_donation_fixture(attrs \\ %{}) do
    attrs = %{
      donorEntityId: attrs[:donorEntityId] || donor_entity_fixture().id,
      donationId: attrs[:donationId] || donation_product_fixture().id
    }

    {:ok, donor_entity_donation} = Aquebra.Logistic.create_donor_entity_donation(attrs)

    donor_entity_donation
  end

  @doc """
  Generate a donation_match.
  """
  def donation_match_fixture(attrs \\ %{}) do
    {:ok, donation_match} =
      attrs
      |> Enum.into(%{})
      |> Aquebra.Logistic.create_donation_match()

    donation_match
  end

  @doc """
  Generate a stock.
  """
  def stock_fixture(attrs \\ %{}) do
    {:ok, stock} =
      attrs
      |> Enum.into(%{
        quantity: 120.5,
        type: "some type"
      })
      |> Aquebra.Logistic.create_stock()

    stock
  end

  @doc """
  Generate a match.
  """
  def match_fixture(attrs \\ %{}) do
    {:ok, match} =
      attrs
      |> Enum.into(%{
        quantity: 120.5,
        type: "some type"
      })
      |> Aquebra.Logistic.create_match()

    match
  end

  @doc """
  Generate a donation.
  """
  def donation_fixture(attrs \\ %{}) do
    {:ok, donation} =
      attrs
      |> Enum.into(%{
        quantity: 120.5,
        type: "some type"
      })
      |> Aquebra.Logistic.create_donation()

    donation
  end

  @doc """
  Generate a demand_evaluation.
  """
  def demand_evaluation_fixture(attrs \\ %{}) do
    {:ok, demand_evaluation} =
      attrs
      |> Enum.into(%{
        match_ids: "some match_ids",
        received_donation: 120.5,
        total_demand: 120.5
      })
      |> Aquebra.Logistic.create_demand_evaluation()

    demand_evaluation
  end

  @doc """
  Generate a donation_evaluation.
  """
  def donation_evaluation_fixture(attrs \\ %{}) do
    {:ok, donation_evaluation} =
      attrs
      |> Enum.into(%{
        match_ids: "some match_ids",
        total_available: 120.5,
        total_donated: 120.5
      })
      |> Aquebra.Logistic.create_donation_evaluation()

    donation_evaluation
  end

  @doc """
  Generate a volunteer_evaluation.
  """
  def volunteer_evaluation_fixture(attrs \\ %{}) do
    {:ok, volunteer_evaluation} =
      attrs
      |> Enum.into(%{
        extra_distance: 120.5,
        match_ids: "some match_ids",
        total_capacity: 120.5,
        used_capacity: 120.5
      })
      |> Aquebra.Logistic.create_volunteer_evaluation()

    volunteer_evaluation
  end
end
