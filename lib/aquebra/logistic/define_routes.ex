defmodule Aquebra.Logistic.DefineRoutes do
  require Logger
  alias Aquebra.Logistic
  alias Aquebra.Logistic.Volunteer
  alias Aquebra.Logistic.Address
  alias RoutePlanner
  alias RouteCalculator

  def getBestRoutes do
    volunteers = Logistic.list_volunteers()

     Enum.each(volunteers, fn volunteer ->
      id = volunteer.id
      origin = volunteer.originAddressId
      destiny = volunteer.destinyAddressId
      %{id: id, origin: origin, destiny: destiny}
#      |> IO.inspect()
#      |> Map.get(:origin)
#      |> IO.inspect()

      bestRoute = getVolunteerBestRoute(origin, destiny)
      Logger.info("Volunteer: #{id}, Best Route: #{inspect(bestRoute.route)}, Distance: #{RouteCalculator.distance(bestRoute)}")
      # Calcular a distância que ja seria realizada, para fazer o delta do adicional
    end)
  end

  defp getVolunteerBestRoute(origin, destiny) do
    originCoordinate = getAddressCoordinates(origin)
    destinyCoordinate = getAddressCoordinates(destiny)
    RoutePlanner.execute(originCoordinate, destinyCoordinate)
  end

  defp getAddressCoordinates(addressId) do
    address = Logistic.get_address!(addressId)
    coordinate = transformStringCoordinatesInTuple(address.coordinates)
  end

  defp transformStringCoordinatesInTuple(string_coordinate) do
    [lat, lon] = string_coordinate
        |> String.split(", ")
        |> Enum.map(&string_to_double/1)

    {lat, lon}
  end
  
  defp string_to_double(string_number) do
    case Float.parse(string_number) do
      {float, ""} -> float
      {float, string} ->
        err = "Number #{string_number} could not be converted to float"
        Logger.critical(err)
        raise(err)
    end
  end

end