defmodule Aquebra.Logistic.DefineRoutes do
  require Logger
  alias Aquebra.Logistic
  alias Aquebra.Logistic.Volunteer
  alias Aquebra.Logistic.Address
  alias Aquebra.Logistic.ReceivingEntity
  alias Aquebra.Logistic.DonorEntity
  alias RoutePlanner
  alias RouteCalculator

  def get_Best_Routes do
    collectPoints = get_Donor_Entities_Addresses()
    deliverPoints = get_Receiving_Entities_Addresses()

    Logistic.list_volunteers()
    |> Enum.each(fn volunteer ->
      id = volunteer.id
      origin = volunteer.originAddressId
      destiny = volunteer.destinyAddressId
      %{id: id, origin: origin, destiny: destiny}

      bestRoute = get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints)

      Logger.info(
        "Volunteer: #{id}, Best Route: #{inspect(bestRoute.route)}, Distance: #{RouteCalculator.distance(bestRoute)}, Extra route distance: #{get_extra_distance_in_route(bestRoute)}"
      )
    end)
  end

  defp get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints) do
    originCoordinate = get_Address_Coordinates(origin)
    destinyCoordinate = get_Address_Coordinates(destiny)
    RoutePlanner.execute(originCoordinate, destinyCoordinate, collectPoints, deliverPoints)
  end

  defp get_Donor_Entities_Addresses() do
    Logistic.list_donorentities()
    # verificar como deixar os dados aqui mais secretos (?)
    |> Enum.map(fn donor_entity ->
      get_Address_Coordinates(donor_entity.addressId)
    end)
  end

  defp get_Receiving_Entities_Addresses() do
    Logistic.list_receivingentities()
    |> Enum.map(fn receiving_entity ->
      get_Address_Coordinates(receiving_entity.addressId)
    end)
  end

  defp get_Address_Coordinates(addressId) do
    address = Logistic.get_address!(addressId)
    coordinate = transform_String_Coordinates_In_Tuple(address.coordinates)
  end

  defp transform_String_Coordinates_In_Tuple(string_coordinate) do
    [lat, lon] =
      string_coordinate
      |> String.split(", ")
      |> Enum.map(&string_to_double/1)

    {lat, lon}
  end

  defp string_to_double(string_number) do
    case Float.parse(string_number) do
      {float, ""} ->
        float

      {float, string} ->
        err = "Number #{string_number} could not be converted to float"
        Logger.critical(err)
        raise(err)
    end
  end

  defp get_extra_distance_in_route(route) do
    [startPoint, collectPoint, deliverPoint, endPoint] = route.route

    usual_distance = RouteCalculator.calculate_distance(startPoint, endPoint)
    total_distance = RouteCalculator.distance(route)

    total_distance - usual_distance
  end
end
