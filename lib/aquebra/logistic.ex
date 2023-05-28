defmodule Aquebra.Logistic do
  @moduledoc """
  The Logistic context.
  """

  import Ecto.Query, warn: false
  alias Aquebra.Repo

  alias Aquebra.Logistic.Document

  @doc """
  Returns the list of documents.
  
  ## Examples
  
      iex> list_documents()
      [%Document{}, ...]
  
  """
  def list_documents do
    Repo.all(Document)
  end

  @doc """
  Gets a single document.
  
  Raises `Ecto.NoResultsError` if the Document does not exist.
  
  ## Examples
  
      iex> get_document!(123)
      %Document{}
  
      iex> get_document!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_document!(id), do: Repo.get!(Document, id)

  @doc """
  Creates a document.
  
  ## Examples
  
      iex> create_document(%{field: value})
      {:ok, %Document{}}
  
      iex> create_document(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_document(attrs \\ %{}) do
    %Document{}
    |> Document.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a document.
  
  ## Examples
  
      iex> update_document(document, %{field: new_value})
      {:ok, %Document{}}
  
      iex> update_document(document, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_document(%Document{} = document, attrs) do
    document
    |> Document.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a document.
  
  ## Examples
  
      iex> delete_document(document)
      {:ok, %Document{}}
  
      iex> delete_document(document)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_document(%Document{} = document) do
    Repo.delete(document)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking document changes.
  
  ## Examples
  
      iex> change_document(document)
      %Ecto.Changeset{data: %Document{}}
  
  """
  def change_document(%Document{} = document, attrs \\ %{}) do
    Document.changeset(document, attrs)
  end

  alias Aquebra.Logistic.User

  @doc """
  Returns the list of users.
  
  ## Examples
  
      iex> list_users()
      [%User{}, ...]
  
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.
  
  Raises `Ecto.NoResultsError` if the User does not exist.
  
  ## Examples
  
      iex> get_user!(123)
      %User{}
  
      iex> get_user!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_firebase_id(firebase_id), do: Repo.get_by(User, firebaseId: firebase_id)

  @doc """
  Creates a user.
  
  ## Examples
  
      iex> create_user(%{field: value})
      {:ok, %User{}}
  
      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  
  ## Examples
  
      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}
  
      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.
  
  ## Examples
  
      iex> delete_user(user)
      {:ok, %User{}}
  
      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  
  ## Examples
  
      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}
  
  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Aquebra.Logistic.Address

  @doc """
  Returns the list of addresses.
  
  ## Examples
  
      iex> list_addresses()
      [%Address{}, ...]
  
  """
  def list_addresses do
    Repo.all(Address)
  end

  @doc """
  Gets a single address.
  
  Raises `Ecto.NoResultsError` if the Address does not exist.
  
  ## Examples
  
      iex> get_address!(123)
      %Address{}
  
      iex> get_address!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_address!(id), do: Repo.get!(Address, id)

  @doc """
  Creates a address.
  
  ## Examples
  
      iex> create_address(%{field: value})
      {:ok, %Address{}}
  
      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a address.
  
  ## Examples
  
      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}
  
      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a address.
  
  ## Examples
  
      iex> delete_address(address)
      {:ok, %Address{}}
  
      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_address(%Address{} = address) do
    Repo.delete(address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking address changes.
  
  ## Examples
  
      iex> change_address(address)
      %Ecto.Changeset{data: %Address{}}
  
  """
  def change_address(%Address{} = address, attrs \\ %{}) do
    Address.changeset(address, attrs)
  end

  alias Aquebra.Logistic.DonationProduct

  @doc """
  Returns the list of donationproducts.
  
  ## Examples
  
      iex> list_donationproducts()
      [%DonationProduct{}, ...]
  
  """
  def list_donationproducts do
    Repo.all(DonationProduct)
  end

  @doc """
  Gets a single donation_product.
  
  Raises `Ecto.NoResultsError` if the Donation product does not exist.
  
  ## Examples
  
      iex> get_donation_product!(123)
      %DonationProduct{}
  
      iex> get_donation_product!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_donation_product!(id), do: Repo.get!(DonationProduct, id)

  @doc """
  Creates a donation_product.
  
  ## Examples
  
      iex> create_donation_product(%{field: value})
      {:ok, %DonationProduct{}}
  
      iex> create_donation_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_donation_product(attrs \\ %{}) do
    %DonationProduct{}
    |> DonationProduct.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a donation_product.
  
  ## Examples
  
      iex> update_donation_product(donation_product, %{field: new_value})
      {:ok, %DonationProduct{}}
  
      iex> update_donation_product(donation_product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_donation_product(%DonationProduct{} = donation_product, attrs) do
    donation_product
    |> DonationProduct.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a donation_product.
  
  ## Examples
  
      iex> delete_donation_product(donation_product)
      {:ok, %DonationProduct{}}
  
      iex> delete_donation_product(donation_product)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_donation_product(%DonationProduct{} = donation_product) do
    Repo.delete(donation_product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking donation_product changes.
  
  ## Examples
  
      iex> change_donation_product(donation_product)
      %Ecto.Changeset{data: %DonationProduct{}}
  
  """
  def change_donation_product(%DonationProduct{} = donation_product, attrs \\ %{}) do
    DonationProduct.changeset(donation_product, attrs)
  end

  alias Aquebra.Logistic.NeededDonation

  @doc """
  Returns the list of neededdonations.
  
  ## Examples
  
      iex> list_neededdonations()
      [%NeededDonation{}, ...]
  
  """
  def list_neededdonations do
    Repo.all(NeededDonation)
  end

  @doc """
  Gets a single needed_donation.
  
  Raises `Ecto.NoResultsError` if the Needed donation does not exist.
  
  ## Examples
  
      iex> get_needed_donation!(123)
      %NeededDonation{}
  
      iex> get_needed_donation!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_needed_donation!(id), do: Repo.get!(NeededDonation, id)

  @doc """
  Creates a needed_donation.
  
  ## Examples
  
      iex> create_needed_donation(%{field: value})
      {:ok, %NeededDonation{}}
  
      iex> create_needed_donation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_needed_donation(attrs \\ %{}) do
    %NeededDonation{}
    |> NeededDonation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a needed_donation.
  
  ## Examples
  
      iex> update_needed_donation(needed_donation, %{field: new_value})
      {:ok, %NeededDonation{}}
  
      iex> update_needed_donation(needed_donation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_needed_donation(%NeededDonation{} = needed_donation, attrs) do
    needed_donation
    |> NeededDonation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a needed_donation.
  
  ## Examples
  
      iex> delete_needed_donation(needed_donation)
      {:ok, %NeededDonation{}}
  
      iex> delete_needed_donation(needed_donation)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_needed_donation(%NeededDonation{} = needed_donation) do
    Repo.delete(needed_donation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking needed_donation changes.
  
  ## Examples
  
      iex> change_needed_donation(needed_donation)
      %Ecto.Changeset{data: %NeededDonation{}}
  
  """
  def change_needed_donation(%NeededDonation{} = needed_donation, attrs \\ %{}) do
    NeededDonation.changeset(needed_donation, attrs)
  end

  alias Aquebra.Logistic.ReceivingEntity

  @doc """
  Returns the list of receivingentities.
  
  ## Examples
  
      iex> list_receivingentities()
      [%ReceivingEntity{}, ...]
  
  """
  def list_receivingentities do
    Repo.all(ReceivingEntity)
  end

  @doc """
  Gets a single receiving_entity.
  
  Raises `Ecto.NoResultsError` if the Receiving entity does not exist.
  
  ## Examples
  
      iex> get_receiving_entity!(123)
      %ReceivingEntity{}
  
      iex> get_receiving_entity!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_receiving_entity!(id), do: Repo.get!(ReceivingEntity, id)

  @doc """
  Creates a receiving_entity.
  
  ## Examples
  
      iex> create_receiving_entity(%{field: value})
      {:ok, %ReceivingEntity{}}
  
      iex> create_receiving_entity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_receiving_entity(attrs \\ %{}) do
    %ReceivingEntity{}
    |> ReceivingEntity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a receiving_entity.
  
  ## Examples
  
      iex> update_receiving_entity(receiving_entity, %{field: new_value})
      {:ok, %ReceivingEntity{}}
  
      iex> update_receiving_entity(receiving_entity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_receiving_entity(%ReceivingEntity{} = receiving_entity, attrs) do
    receiving_entity
    |> ReceivingEntity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a receiving_entity.
  
  ## Examples
  
      iex> delete_receiving_entity(receiving_entity)
      {:ok, %ReceivingEntity{}}
  
      iex> delete_receiving_entity(receiving_entity)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_receiving_entity(%ReceivingEntity{} = receiving_entity) do
    Repo.delete(receiving_entity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking receiving_entity changes.
  
  ## Examples
  
      iex> change_receiving_entity(receiving_entity)
      %Ecto.Changeset{data: %ReceivingEntity{}}
  
  """
  def change_receiving_entity(%ReceivingEntity{} = receiving_entity, attrs \\ %{}) do
    ReceivingEntity.changeset(receiving_entity, attrs)
  end

  alias Aquebra.Logistic.DonorEntity

  @doc """
  Returns the list of donorentities.
  
  ## Examples
  
      iex> list_donorentities()
      [%DonorEntity{}, ...]
  
  """
  def list_donorentities do
    Repo.all(DonorEntity)
  end

  @doc """
  Gets a single donor_entity.
  
  Raises `Ecto.NoResultsError` if the Donor entity does not exist.
  
  ## Examples
  
      iex> get_donor_entity!(123)
      %DonorEntity{}
  
      iex> get_donor_entity!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_donor_entity!(id), do: Repo.get!(DonorEntity, id)

  @doc """
  Creates a donor_entity.
  
  ## Examples
  
      iex> create_donor_entity(%{field: value})
      {:ok, %DonorEntity{}}
  
      iex> create_donor_entity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_donor_entity(attrs \\ %{}) do
    %DonorEntity{}
    |> DonorEntity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a donor_entity.
  
  ## Examples
  
      iex> update_donor_entity(donor_entity, %{field: new_value})
      {:ok, %DonorEntity{}}
  
      iex> update_donor_entity(donor_entity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_donor_entity(%DonorEntity{} = donor_entity, attrs) do
    donor_entity
    |> DonorEntity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a donor_entity.
  
  ## Examples
  
      iex> delete_donor_entity(donor_entity)
      {:ok, %DonorEntity{}}
  
      iex> delete_donor_entity(donor_entity)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_donor_entity(%DonorEntity{} = donor_entity) do
    Repo.delete(donor_entity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking donor_entity changes.
  
  ## Examples
  
      iex> change_donor_entity(donor_entity)
      %Ecto.Changeset{data: %DonorEntity{}}
  
  """
  def change_donor_entity(%DonorEntity{} = donor_entity, attrs \\ %{}) do
    DonorEntity.changeset(donor_entity, attrs)
  end

  alias Aquebra.Logistic.Volunteer

  @doc """
  Returns the list of volunteers.
  
  ## Examples
  
      iex> list_volunteers()
      [%Volunteer{}, ...]
  
  """
  def list_volunteers do
    Repo.all(Volunteer)
  end

  @doc """
  Gets a single volunteer.
  
  Raises `Ecto.NoResultsError` if the Volunteer does not exist.
  
  ## Examples
  
      iex> get_volunteer!(123)
      %Volunteer{}
  
      iex> get_volunteer!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_volunteer!(id), do: Repo.get!(Volunteer, id)

  @doc """
  Creates a volunteer.
  
  ## Examples
  
      iex> create_volunteer(%{field: value})
      {:ok, %Volunteer{}}
  
      iex> create_volunteer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_volunteer(attrs \\ %{}) do
    %Volunteer{}
    |> Volunteer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a volunteer.
  
  ## Examples
  
      iex> update_volunteer(volunteer, %{field: new_value})
      {:ok, %Volunteer{}}
  
      iex> update_volunteer(volunteer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_volunteer(%Volunteer{} = volunteer, attrs) do
    volunteer
    |> Volunteer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a volunteer.
  
  ## Examples
  
      iex> delete_volunteer(volunteer)
      {:ok, %Volunteer{}}
  
      iex> delete_volunteer(volunteer)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_volunteer(%Volunteer{} = volunteer) do
    Repo.delete(volunteer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking volunteer changes.
  
  ## Examples
  
      iex> change_volunteer(volunteer)
      %Ecto.Changeset{data: %Volunteer{}}
  
  """
  def change_volunteer(%Volunteer{} = volunteer, attrs \\ %{}) do
    Volunteer.changeset(volunteer, attrs)
  end

  alias Aquebra.Logistic.TownHallUser

  @doc """
  Returns the list of townhallusers.
  
  ## Examples
  
      iex> list_townhallusers()
      [%TownHallUser{}, ...]
  
  """
  def list_townhallusers do
    Repo.all(TownHallUser)
  end

  @doc """
  Gets a single town_hall_user.
  
  Raises `Ecto.NoResultsError` if the Town hall user does not exist.
  
  ## Examples
  
      iex> get_town_hall_user!(123)
      %TownHallUser{}
  
      iex> get_town_hall_user!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_town_hall_user!(id), do: Repo.get!(TownHallUser, id)

  @doc """
  Creates a town_hall_user.
  
  ## Examples
  
      iex> create_town_hall_user(%{field: value})
      {:ok, %TownHallUser{}}
  
      iex> create_town_hall_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_town_hall_user(attrs \\ %{}) do
    %TownHallUser{}
    |> TownHallUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a town_hall_user.
  
  ## Examples
  
      iex> update_town_hall_user(town_hall_user, %{field: new_value})
      {:ok, %TownHallUser{}}
  
      iex> update_town_hall_user(town_hall_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_town_hall_user(%TownHallUser{} = town_hall_user, attrs) do
    town_hall_user
    |> TownHallUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a town_hall_user.
  
  ## Examples
  
      iex> delete_town_hall_user(town_hall_user)
      {:ok, %TownHallUser{}}
  
      iex> delete_town_hall_user(town_hall_user)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_town_hall_user(%TownHallUser{} = town_hall_user) do
    Repo.delete(town_hall_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking town_hall_user changes.
  
  ## Examples
  
      iex> change_town_hall_user(town_hall_user)
      %Ecto.Changeset{data: %TownHallUser{}}
  
  """
  def change_town_hall_user(%TownHallUser{} = town_hall_user, attrs \\ %{}) do
    TownHallUser.changeset(town_hall_user, attrs)
  end

  alias Aquebra.Logistic.DonorEntityDonation

  @doc """
  Returns the list of donorentitydonation.
  
  ## Examples
  
      iex> list_donor_entity_donation()
      [%DonorEntityDonation{}, ...]
  
  """
  def list_donor_entity_donation do
    Repo.all(DonorEntityDonation)
  end

  @doc """
  Gets a single donor_entity_donation.
  
  Raises `Ecto.NoResultsError` if the Donor entity donation does not exist.
  
  ## Examples
  
      iex> get_donor_entity_donation!(123)
      %DonorEntityDonation{}
  
      iex> get_donor_entity_donation!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_donor_entity_donation!(id), do: Repo.get!(DonorEntityDonation, id)

  @doc """
  Creates a donor_entity_donation.
  
  ## Examples
  
      iex> create_donor_entity_donation(%{field: value})
      {:ok, %DonorEntityDonation{}}
  
      iex> create_donor_entity_donation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_donor_entity_donation(attrs \\ %{}) do
    %DonorEntityDonation{}
    |> DonorEntityDonation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a donor_entity_donation.
  
  ## Examples
  
      iex> update_donor_entity_donation(donor_entity_donation, %{field: new_value})
      {:ok, %DonorEntityDonation{}}
  
      iex> update_donor_entity_donation(donor_entity_donation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_donor_entity_donation(%DonorEntityDonation{} = donor_entity_donation, attrs) do
    donor_entity_donation
    |> DonorEntityDonation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a donor_entity_donation.
  
  ## Examples
  
      iex> delete_donor_entity_donation(donor_entity_donation)
      {:ok, %DonorEntityDonation{}}
  
      iex> delete_donor_entity_donation(donor_entity_donation)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_donor_entity_donation(%DonorEntityDonation{} = donor_entity_donation) do
    Repo.delete(donor_entity_donation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking donor_entity_donation changes.
  
  ## Examples
  
      iex> change_donor_entity_donation(donor_entity_donation)
      %Ecto.Changeset{data: %DonorEntityDonation{}}
  
  """
  def change_donor_entity_donation(%DonorEntityDonation{} = donor_entity_donation, attrs \\ %{}) do
    DonorEntityDonation.changeset(donor_entity_donation, attrs)
  end

  def get_entity_id_from_donor_entity_donation_by_donation_id(donation_Id),
    do: Repo.get_by(DonorEntityDonation, donationId: donation_Id)

  alias Aquebra.Logistic.DonationMatch

  @doc """
  Returns the list of donationmatches.
  
  ## Examples
  
      iex> list_donationmatches()
      [%DonationMatch{}, ...]
  
  """
  def list_donationmatches do
    Repo.all(DonationMatch)
  end

  @doc """
  Gets a single donation_match.
  
  Raises `Ecto.NoResultsError` if the Donation match does not exist.
  
  ## Examples
  
      iex> get_donation_match!(123)
      %DonationMatch{}
  
      iex> get_donation_match!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_donation_match!(id), do: Repo.get!(DonationMatch, id)

  @doc """
  Creates a donation_match.
  
  ## Examples
  
      iex> create_donation_match(%{field: value})
      {:ok, %DonationMatch{}}
  
      iex> create_donation_match(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_donation_match(attrs \\ %{}) do
    %DonationMatch{}
    |> DonationMatch.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a donation_match.
  
  ## Examples
  
      iex> update_donation_match(donation_match, %{field: new_value})
      {:ok, %DonationMatch{}}
  
      iex> update_donation_match(donation_match, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_donation_match(%DonationMatch{} = donation_match, attrs) do
    donation_match
    |> DonationMatch.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a donation_match.
  
  ## Examples
  
      iex> delete_donation_match(donation_match)
      {:ok, %DonationMatch{}}
  
      iex> delete_donation_match(donation_match)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_donation_match(%DonationMatch{} = donation_match) do
    Repo.delete(donation_match)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking donation_match changes.
  
  ## Examples
  
      iex> change_donation_match(donation_match)
      %Ecto.Changeset{data: %DonationMatch{}}
  
  """
  def change_donation_match(%DonationMatch{} = donation_match, attrs \\ %{}) do
    DonationMatch.changeset(donation_match, attrs)
  end

  alias Aquebra.Logistic.Stock

  @doc """
  Returns the list of stocks.
  
  ## Examples
  
      iex> list_stocks()
      [%Stock{}, ...]
  
  """
  def list_stocks do
    Repo.all(Stock)
  end

  @doc """
  Gets a single stock.
  
  Raises `Ecto.NoResultsError` if the Stock does not exist.
  
  ## Examples
  
      iex> get_stock!(123)
      %Stock{}
  
      iex> get_stock!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_stock!(id), do: Repo.get!(Stock, id)

  @doc """
  Creates a stock.
  
  ## Examples
  
      iex> create_stock(%{field: value})
      {:ok, %Stock{}}
  
      iex> create_stock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_stock(attrs \\ %{}) do
    %Stock{}
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock.
  
  ## Examples
  
      iex> update_stock(stock, %{field: new_value})
      {:ok, %Stock{}}
  
      iex> update_stock(stock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stock.
  
  ## Examples
  
      iex> delete_stock(stock)
      {:ok, %Stock{}}
  
      iex> delete_stock(stock)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_stock(%Stock{} = stock) do
    Repo.delete(stock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock changes.
  
  ## Examples
  
      iex> change_stock(stock)
      %Ecto.Changeset{data: %Stock{}}
  
  """
  def change_stock(%Stock{} = stock, attrs \\ %{}) do
    Stock.changeset(stock, attrs)
  end
end
