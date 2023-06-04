defmodule Aquebra.Logistic.DefineRoutes do
  require Logger
  alias Aquebra.Logistic
  alias Aquebra.Logistic.Volunteer
  alias Aquebra.Logistic.Address
  alias Aquebra.Logistic.ReceivingEntity
  alias Aquebra.Logistic.DonorEntity
  alias Aquebra.Logistic.Match
  alias RoutePlanner
  alias RouteCalculator
  alias Aquebra.Genetic.EntityCoordinate
  alias Aquebra.Genetic.LocationCollect
  alias Aquebra.Genetic.LocationDeliver

  def get_best_routes do
    Logistic.list_volunteers()
    |> Enum.each(fn volunteer ->
      {id, origin, destiny, collectPoints, deliverPoints} = assemble_volunteer_data(volunteer)
      bestRoute = get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints)

      Logger.info(
        #        "Volunteer: #{id}, Best Route: #{inspect(bestRoute.route)}, Distance: #{RouteCalculator.distance(bestRoute)}, Extra route distance: #{get_extra_distance_in_route(bestRoute)}\n"
        "Volunteer: #{id}, Total distance: #{RouteCalculator.distance(bestRoute)}, Extra route distance: #{get_extra_distance_in_route(bestRoute)}\n"
      )
    end)
  end

  defp assemble_volunteer_data(volunteer) do
    id = volunteer.id
    origin = get_Address_Coordinates(volunteer.originAddressId)
    destiny = get_Address_Coordinates(volunteer.destinyAddressId)
    # collectPoints = get_Donor_Entities_Coordinates(origin, id)
    # deliverPoints = get_Receiving_Entities_Coordinates(destiny, id)
    collectPoints = get_collect_points_from_stock()
    deliverPoints = get_deliver_points_from_needed_donation()
    {id, origin, destiny, collectPoints, deliverPoints}
  end

  defp get_collect_points_from_stock() do
    Logistic.list_stocks()
    |> Enum.map(fn stock ->
      entity = Logistic.get_donor_entity!(stock.donorEntityId)
      coordinates = get_Address_Coordinates(entity.addressId)

      %LocationCollect{
        entity_position: coordinates,
        entity_id: entity.id,
        stock_id: stock.id,
        donation_quantity: stock.quantity,
        donation_type: stock.type
      }
    end)
  end

  defp get_deliver_points_from_needed_donation() do
    Logistic.list_neededdonations()
    |> Enum.map(fn demand ->
      entity = Logistic.get_receiving_entity!(demand.receivingEntityId)
      coordinates = get_Address_Coordinates(entity.addressId)

      %LocationDeliver{
        entity_position: coordinates,
        entity_id: entity.id,
        needed_donation_id: demand.id,
        receiving_quantity: demand.quantity,
        receiving_type: demand.type
      }
    end)
  end

  #  defp assemble_volunteer_data(volunteer) do
  #    id = volunteer.id
  #    origin = get_Address_Coordinates(volunteer.originAddressId)
  #    destiny = get_Address_Coordinates(volunteer.destinyAddressId)
  #    collectPoints = get_Donor_Entities_Coordinates(origin, id)
  #    |> IO.inspect
  #    deliverPoints = get_Receiving_Entities_Coordinates(destiny, id)
  #    |> IO.inspect
  #    {id, origin, destiny, collectPoints, deliverPoints}
  #  end

  defp get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints) do
    RoutePlanner.execute(origin, destiny, collectPoints, deliverPoints)
  end

  defp get_Donor_Entities_Coordinates(origin, volunteer_id) do
    Logistic.list_donorentities()
    |> Enum.map(fn donor_entity ->
      {donor_entity, get_Address_Coordinates(donor_entity.addressId)}
    end)
    |> get_nearest_points(origin, 10)
    |> create_volunteer_matches(volunteer_id)

    get_closer_donor_entities_with_matches(volunteer_id)
  end

  defp get_closer_donor_entities_with_matches(volunteer_id) do
    Match.find_match_by_volunteer_id(volunteer_id)
    |> Enum.map(fn match ->
      Logistic.get_donor_entity!(match.donor_entity_id)
    end)
    |> Enum.map(fn donor_entity ->
      get_Address_Coordinates(donor_entity.addressId)
    end)
    |> Enum.uniq()
  end

  defp get_receiving_entities_for_donor_entity_match(match) do
    Logistic.get_match_by_donor_entity_id(match.donor_entity_id)
  end

  defp create_volunteer_matches(donor_entity_list, volunteer_id) do
    donor_entity_list
    |> Enum.each(fn donor ->
      {donor_entity, coordinate} = donor
      Match.create_matches_for_volunteer(volunteer_id, donor_entity.id)
    end)

    donor_entity_list
  end

  defp get_coordinate_field(entity_tuples) do
    entity_tuples
    |> Enum.map(fn tuple ->
      {entity, coordinate} = tuple
      coordinate
    end)
  end

  defp get_Receiving_Entities_Coordinates(destiny, donor_entity_id) do
    Logistic.get_match_by_donor_entity_id(donor_entity_id)
    |> Enum.map(fn match ->
      Logistic.get_receiving_entity!(match.receiving_entity_id)
    end)
    |> Enum.map(fn receiving_entity ->
      {receiving_entity, get_Address_Coordinates(receiving_entity.addressId)}
    end)
    |> Enum.uniq()
    |> get_nearest_points(destiny, 5)
    |> get_coordinate_field()
  end

  #  defp get_Receiving_Entities_Coordinates(destiny, volunteer_id) do
  #    Match.find_match_by_volunteer_id(volunteer_id)
  #    |> Enum.map(fn match ->
  #      Logistic.get_receiving_entity!(match.receiving_entity_id)
  #    end)
  #    |> Enum.map(fn receiving_entity ->
  #      {receiving_entity, get_Address_Coordinates(receiving_entity.addressId)}
  #    end)
  #    |> Enum.uniq()
  #    |> get_nearest_points(destiny, 5)
  #    |> get_coordinate_field()
  #  end

  defp get_nearest_points(end_point_list, start_point, points_quantity) do
    end_point_list
    |> Enum.map(fn {entity, end_point} ->
      {entity, RouteCalculator.calculate_distance(start_point, end_point)}
    end)
    |> Enum.with_index()
    |> Enum.sort_by(fn {{entity, end_point}, _index} -> end_point end, :asc)
    |> Enum.take(points_quantity)
    |> Enum.map(fn point ->
      {{entity, distance_calculated}, index} = point
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
    #    [startPoint, collectPoint, deliverPoint, endPoint] = route.route
    [startPoint, collectPoint, deliverPoint, endPoint] = [
      route.start_point,
      route.collect_point.entity_position,
      route.deliver_point.entity_position,
      route.end_point
    ]

    usual_distance = RouteCalculator.calculate_distance(startPoint, endPoint)
    total_distance = RouteCalculator.distance(route)

    total_distance - usual_distance
  end
end
