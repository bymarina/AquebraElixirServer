defmodule Aquebra.Logistic.Volunteer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Aquebra.Logistic
  alias Aquebra.Logistic.Match

  schema "volunteers" do
    field :name, :string
    field :picture, :string
    field :vehicleCapacity, :integer
    field :userId, :id
    field :documentNumberId, :id
    field :originAddressId, :id
    field :destinyAddressId, :id

    timestamps()
  end

  @doc false
  def changeset(volunteer, attrs) do
    volunteer
    |> cast(attrs, [:name, :vehicleCapacity, :picture])
    |> validate_required([:name, :vehicleCapacity, :picture])
  end

  def apply_volunteer_match(match, volunteer, url) do
    vehicle_capacity = volunteer.vehicleCapacity
    match_quantity = match.collect_point.donation_quantity
    capacity_left = vehicle_capacity - get_current_volunteer_vehicle_fill(volunteer)

    if does_donation_fit_vehicle_completely(match_quantity, capacity_left) do
      Match.create_match_from_route(volunteer.id, match, match_quantity, url)
      vehicle_capacity = capacity_left - match_quantity
      match_quantity = 0
    end

    if does_donation_fit_vehicle_partially(match_quantity, capacity_left) do
      Match.create_match_from_route(volunteer.id, match, capacity_left, url)
      capacity_left = 0
    end
  end

  defp get_current_volunteer_vehicle_fill(volunteer) do
    Logistic.get_match_by_volunteer_id(volunteer.id)
    |> Enum.reduce(0, fn match, acc ->
      acc = acc + match.quantity
    end)
  end

  def does_donation_fit_vehicle_completely(donation_quantity, vehicle_capacity) do
    if vehicle_capacity >= donation_quantity && donation_quantity > 0 do
      true
    else
      false
    end
  end

  def does_donation_fit_vehicle_partially(donation_quantity, vehicle_capacity) do
    if vehicle_capacity > 0 && donation_quantity > 0 && vehicle_capacity < donation_quantity do
      true
    else
      false
    end
  end
end
