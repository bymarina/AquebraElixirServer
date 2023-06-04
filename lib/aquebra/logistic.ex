defmodule Aquebra.Logistic do
  @moduledoc """
  The Logistic context.
  """

  import Ecto.Query, warn: false
  alias Aquebra.Repo

  alias Aquebra.Logistic.Document

  def list_documents do
    Repo.all(Document)
  end

  def get_document!(id), do: Repo.get!(Document, id)

  def create_document(attrs \\ %{}) do
    %Document{}
    |> Document.changeset(attrs)
    |> Repo.insert()
  end

  def update_document(%Document{} = document, attrs) do
    document
    |> Document.changeset(attrs)
    |> Repo.update()
  end

  def delete_document(%Document{} = document) do
    Repo.delete(document)
  end

  def change_document(%Document{} = document, attrs \\ %{}) do
    Document.changeset(document, attrs)
  end

  alias Aquebra.Logistic.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_firebase_id(firebase_id), do: Repo.get_by(User, firebaseId: firebase_id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Aquebra.Logistic.Address

  def list_addresses do
    Repo.all(Address)
  end

  def get_address!(id), do: Repo.get!(Address, id)

  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end

  def delete_address(%Address{} = address) do
    Repo.delete(address)
  end

  def change_address(%Address{} = address, attrs \\ %{}) do
    Address.changeset(address, attrs)
  end

  alias Aquebra.Logistic.DonationProduct

  def list_donationproducts do
    Repo.all(DonationProduct)
  end

  def get_donation_product!(id), do: Repo.get!(DonationProduct, id)

  def create_donation_product(attrs \\ %{}) do
    %DonationProduct{}
    |> DonationProduct.changeset(attrs)
    |> Repo.insert()
  end

  def update_donation_product(%DonationProduct{} = donation_product, attrs) do
    donation_product
    |> DonationProduct.changeset(attrs)
    |> Repo.update()
  end

  def delete_donation_product(%DonationProduct{} = donation_product) do
    Repo.delete(donation_product)
  end

  def change_donation_product(%DonationProduct{} = donation_product, attrs \\ %{}) do
    DonationProduct.changeset(donation_product, attrs)
  end

  alias Aquebra.Logistic.NeededDonation

  def list_neededdonations do
    Repo.all(NeededDonation)
  end

  def get_needed_donation!(id), do: Repo.get!(NeededDonation, id)

  def create_needed_donation(attrs \\ %{}) do
    %NeededDonation{}
    |> NeededDonation.changeset(attrs)
    |> Repo.insert()
  end

  def update_needed_donation(%NeededDonation{} = needed_donation, attrs) do
    needed_donation
    |> NeededDonation.changeset(attrs)
    |> Repo.update()
  end

  def delete_needed_donation(%NeededDonation{} = needed_donation) do
    Repo.delete(needed_donation)
  end

  def change_needed_donation(%NeededDonation{} = needed_donation, attrs \\ %{}) do
    NeededDonation.changeset(needed_donation, attrs)
  end

  def get_needed_donation_by_type(type) do
    Repo.get_by(NeededDonation, type: type)
  end

  def get_needed_donation_by_entity_id(entity_id) do
    query =
      from d in "neededdonations",
        where: d.receivingEntityId == ^entity_id,
        select: [:id, :type, :quantity, :receivingEntityId]

    Repo.all(query)
  end

  alias Aquebra.Logistic.ReceivingEntity

  def list_receivingentities do
    Repo.all(ReceivingEntity)
  end

  def get_receiving_entity!(id), do: Repo.get!(ReceivingEntity, id)

  def create_receiving_entity(attrs \\ %{}) do
    %ReceivingEntity{}
    |> ReceivingEntity.changeset(attrs)
    |> Repo.insert()
  end

  def update_receiving_entity(%ReceivingEntity{} = receiving_entity, attrs) do
    receiving_entity
    |> ReceivingEntity.changeset(attrs)
    |> Repo.update()
  end

  def delete_receiving_entity(%ReceivingEntity{} = receiving_entity) do
    Repo.delete(receiving_entity)
  end

  def change_receiving_entity(%ReceivingEntity{} = receiving_entity, attrs \\ %{}) do
    ReceivingEntity.changeset(receiving_entity, attrs)
  end

  alias Aquebra.Logistic.DonorEntity

  def list_donorentities do
    Repo.all(DonorEntity)
  end

  def get_donor_entity!(id), do: Repo.get!(DonorEntity, id)

  def create_donor_entity(attrs \\ %{}) do
    %DonorEntity{}
    |> DonorEntity.changeset(attrs)
    |> Repo.insert()
  end

  def update_donor_entity(%DonorEntity{} = donor_entity, attrs) do
    donor_entity
    |> DonorEntity.changeset(attrs)
    |> Repo.update()
  end

  def delete_donor_entity(%DonorEntity{} = donor_entity) do
    Repo.delete(donor_entity)
  end

  def change_donor_entity(%DonorEntity{} = donor_entity, attrs \\ %{}) do
    DonorEntity.changeset(donor_entity, attrs)
  end

  alias Aquebra.Logistic.Volunteer

  def list_volunteers do
    Repo.all(Volunteer)
  end

  def get_volunteer!(id), do: Repo.get!(Volunteer, id)

  def create_volunteer(attrs \\ %{}) do
    %Volunteer{}
    |> Volunteer.changeset(attrs)
    |> Repo.insert()
  end

  def update_volunteer(%Volunteer{} = volunteer, attrs) do
    volunteer
    |> Volunteer.changeset(attrs)
    |> Repo.update()
  end

  def delete_volunteer(%Volunteer{} = volunteer) do
    Repo.delete(volunteer)
  end

  def change_volunteer(%Volunteer{} = volunteer, attrs \\ %{}) do
    Volunteer.changeset(volunteer, attrs)
  end

  alias Aquebra.Logistic.TownHallUser

  def list_townhallusers do
    Repo.all(TownHallUser)
  end

  def get_town_hall_user!(id), do: Repo.get!(TownHallUser, id)

  def create_town_hall_user(attrs \\ %{}) do
    %TownHallUser{}
    |> TownHallUser.changeset(attrs)
    |> Repo.insert()
  end

  def update_town_hall_user(%TownHallUser{} = town_hall_user, attrs) do
    town_hall_user
    |> TownHallUser.changeset(attrs)
    |> Repo.update()
  end

  def delete_town_hall_user(%TownHallUser{} = town_hall_user) do
    Repo.delete(town_hall_user)
  end

  def change_town_hall_user(%TownHallUser{} = town_hall_user, attrs \\ %{}) do
    TownHallUser.changeset(town_hall_user, attrs)
  end

  alias Aquebra.Logistic.DonorEntityDonation

  def list_donor_entity_donation do
    Repo.all(DonorEntityDonation)
  end

  def get_donor_entity_donation!(id), do: Repo.get!(DonorEntityDonation, id)

  def create_donor_entity_donation(attrs \\ %{}) do
    %DonorEntityDonation{}
    |> DonorEntityDonation.changeset(attrs)
    |> Repo.insert()
  end

  def update_donor_entity_donation(%DonorEntityDonation{} = donor_entity_donation, attrs) do
    donor_entity_donation
    |> DonorEntityDonation.changeset(attrs)
    |> Repo.update()
  end

  def delete_donor_entity_donation(%DonorEntityDonation{} = donor_entity_donation) do
    Repo.delete(donor_entity_donation)
  end

  def change_donor_entity_donation(%DonorEntityDonation{} = donor_entity_donation, attrs \\ %{}) do
    DonorEntityDonation.changeset(donor_entity_donation, attrs)
  end

  def get_entity_id_from_donor_entity_donation_by_donation_id(donation_Id),
    do: Repo.get_by(DonorEntityDonation, donationId: donation_Id)

  def get_donation_id_from_entity_id(entity_id) do
    query =
      from d in "donorentitydonation",
        where: d.donorEntityId == ^entity_id,
        select: [:donationId]

    Repo.all(query)
  end

  alias Aquebra.Logistic.DonationMatch

  def list_donationmatches do
    Repo.all(DonationMatch)
  end

  def get_donation_match!(id), do: Repo.get!(DonationMatch, id)

  def create_donation_match(attrs \\ %{}) do
    %DonationMatch{}
    |> DonationMatch.changeset(attrs)
    |> Repo.insert()
  end

  def update_donation_match(%DonationMatch{} = donation_match, attrs) do
    donation_match
    |> DonationMatch.changeset(attrs)
    |> Repo.update()
  end

  def delete_donation_match(%DonationMatch{} = donation_match) do
    Repo.delete(donation_match)
  end

  def change_donation_match(%DonationMatch{} = donation_match, attrs \\ %{}) do
    DonationMatch.changeset(donation_match, attrs)
  end

  alias Aquebra.Logistic.Stock

  def list_stocks do
    Repo.all(Stock)
  end

  def get_stock!(id), do: Repo.get!(Stock, id)

  def create_stock(attrs \\ %{}) do
    %Stock{}
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end

  def delete_stock(%Stock{} = stock) do
    Repo.delete(stock)
  end

  def delete_all_stock() do
    query =
      from s in "stocks",
        select: [:id]

    Repo.delete_all(query)
  end

  def change_stock(%Stock{} = stock, attrs \\ %{}) do
    Stock.changeset(stock, attrs)
  end

  def get_stock_by_entity_id(entity_id) do
    query =
      from u in "stocks",
        where: u.donorEntityId == ^entity_id,
        select: [:id, :type, :quantity, :donorEntityId]

    Repo.all(query)
  end

  alias Aquebra.Logistic.Match

  def list_matches do
    Repo.all(Match)
  end

  def get_match!(id), do: Repo.get!(Match, id)

  def create_match(attrs \\ %{}) do
    %Match{}
    |> Match.changeset(attrs)
    |> Repo.insert()
  end

  def update_match(%Match{} = match, attrs) do
    match
    |> Match.changeset(attrs)
    |> Repo.update()
  end

  def delete_match(%Match{} = match) do
    Repo.delete(match)
  end

  def delete_all_matches() do
    query =
      from s in "matches",
        select: [:id]

    Repo.delete_all(query)
  end

  def change_match(%Match{} = match, attrs \\ %{}) do
    Match.changeset(match, attrs)
  end

  def get_match_by_volunteer_id(volunteer_id) do
    query =
      from m in "matches",
        where: m.volunteer_id == ^volunteer_id,
        select: [:id, :type, :quantity, :donor_entity_id, :receiving_entity_id, :volunteer_id, :stock_id]

    Repo.all(query)
  end

  def get_match_by_donor_entity_id(donor_entity_id) do
    query =
      from m in "matches",
        where: m.donor_entity_id == ^donor_entity_id,
        select: [:id, :type, :quantity, :donor_entity_id, :receiving_entity_id, :volunteer_id, :stock_id]

    Repo.all(query)
  end

  def get_match_by_receiving_entity_id(entity_id) do
    query =
      from m in "matches",
        where: m.receiving_entity_id == ^entity_id,
        select: [:id, :type, :quantity, :donor_entity_id, :receiving_entity_id, :volunteer_id, :stock_id]

    Repo.all(query)
  end

  alias Aquebra.Logistic.Donation

  def list_donations do
    Repo.all(Donation)
  end

  def get_donation!(id), do: Repo.get!(Donation, id)

  def create_donation(attrs \\ %{}) do
    %Donation{}
    |> Donation.changeset(attrs)
    |> Repo.insert()
  end

  def update_donation(%Donation{} = donation, attrs) do
    donation
    |> Donation.changeset(attrs)
    |> Repo.update()
  end

  def delete_donation(%Donation{} = donation) do
    Repo.delete(donation)
  end

  def change_donation(%Donation{} = donation, attrs \\ %{}) do
    Donation.changeset(donation, attrs)
  end

  alias Aquebra.Logistic.Demand_evaluation

  def list_demands_evaluation do
    Repo.all(Demand_evaluation)
  end

  def get_demand_evaluation!(id), do: Repo.get!(Demand_evaluation, id)

  def create_demand_evaluation(attrs \\ %{}) do
    %Demand_evaluation{}
    |> Demand_evaluation.changeset(attrs)
    |> Repo.insert()
  end

  def update_demand_evaluation(%Demand_evaluation{} = demand_evaluation, attrs) do
    demand_evaluation
    |> Demand_evaluation.changeset(attrs)
    |> Repo.update()
  end

  def delete_demand_evaluation(%Demand_evaluation{} = demand_evaluation) do
    Repo.delete(demand_evaluation)
  end

  def change_demand_evaluation(%Demand_evaluation{} = demand_evaluation, attrs \\ %{}) do
    Demand_evaluation.changeset(demand_evaluation, attrs)
  end

  def delete_all_demand_evaluation() do
    query =
      from de in "demands_evaluation",
        select: [:id]

    Repo.delete_all(query)
  end

  alias Aquebra.Logistic.Donation_evaluation

  def list_donations_evaluation do
    Repo.all(Donation_evaluation)
  end

  def get_donation_evaluation!(id), do: Repo.get!(Donation_evaluation, id)

  def create_donation_evaluation(attrs \\ %{}) do
    %Donation_evaluation{}
    |> Donation_evaluation.changeset(attrs)
    |> Repo.insert()
  end

  def update_donation_evaluation(%Donation_evaluation{} = donation_evaluation, attrs) do
    donation_evaluation
    |> Donation_evaluation.changeset(attrs)
    |> Repo.update()
  end

  def delete_donation_evaluation(%Donation_evaluation{} = donation_evaluation) do
    Repo.delete(donation_evaluation)
  end

  def delete_all_donation_evaluation() do
    query =
      from de in "donations_evaluation",
        select: [:id]

    Repo.delete_all(query)
  end

  def change_donation_evaluation(%Donation_evaluation{} = donation_evaluation, attrs \\ %{}) do
    Donation_evaluation.changeset(donation_evaluation, attrs)
  end

  alias Aquebra.Logistic.Volunteer_evaluation

  def list_volunteers_evaluation do
    Repo.all(Volunteer_evaluation)
  end

  def get_volunteer_evaluation!(id), do: Repo.get!(Volunteer_evaluation, id)

  def create_volunteer_evaluation(attrs \\ %{}) do
    %Volunteer_evaluation{}
    |> Volunteer_evaluation.changeset(attrs)
    |> Repo.insert()
  end

  def update_volunteer_evaluation(%Volunteer_evaluation{} = volunteer_evaluation, attrs) do
    volunteer_evaluation
    |> Volunteer_evaluation.changeset(attrs)
    |> Repo.update()
  end

  def delete_volunteer_evaluation(%Volunteer_evaluation{} = volunteer_evaluation) do
    Repo.delete(volunteer_evaluation)
  end

  def change_volunteer_evaluation(%Volunteer_evaluation{} = volunteer_evaluation, attrs \\ %{}) do
    Volunteer_evaluation.changeset(volunteer_evaluation, attrs)
  end
end
