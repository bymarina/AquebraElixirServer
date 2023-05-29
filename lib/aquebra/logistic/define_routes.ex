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

    Logistic.list_volunteers()
    |> Enum.each(fn volunteer ->
      id = volunteer.id
      origin = get_Address_Coordinates(volunteer.originAddressId)
      destiny = get_Address_Coordinates(volunteer.destinyAddressId)
      collectPoints = get_Donor_Entities_Addresses(origin)
      deliverPoints = get_Receiving_Entities_Addresses(destiny)
      %{id: id, origin: origin, destiny: destiny}

      bestRoute = get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints)

      Logger.info(
        "Volunteer: #{id}, Best Route: #{inspect(bestRoute.route)}, Distance: #{RouteCalculator.distance(bestRoute)}, Extra route distance: #{get_extra_distance_in_route(bestRoute)}"
      )
    end)
  end

  defp get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints) do
    RoutePlanner.execute(origin, destiny, collectPoints, deliverPoints)
  end

  defp get_Donor_Entities_Addresses(origin) do
    Logistic.list_donorentities()
    |> Enum.map(fn donor_entity ->
      get_Address_Coordinates(donor_entity.addressId)
    end)
    |> get_nearest_points(origin, 10)
  end

  defp get_Receiving_Entities_Addresses(destiny) do
    Logistic.list_receivingentities()
    |> Enum.map(fn receiving_entity ->
      get_Address_Coordinates(receiving_entity.addressId)
    end)
    |> get_nearest_points(destiny, 5)
  end

  defp get_nearest_points(end_point_list, start_point, points_quantity) do
    end_point_list
    |> Enum.map(fn end_point ->
      RouteCalculator.calculate_distance(start_point, end_point)
    end)
    |> Enum.with_index()
    |> Enum.sort(:asc)
    |> Enum.take(points_quantity)
    |> Enum.map(fn point ->
      {distance_calculated, index} = point
      Enum.at(end_point_list, index)
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
