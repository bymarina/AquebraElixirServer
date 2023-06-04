defmodule Aquebra.Logistic.DefineRoutes do
  require Logger
  alias Aquebra.Logistic
  alias Aquebra.Logistic.Volunteer
  alias Aquebra.Logistic.Address
  alias Aquebra.Logistic.ReceivingEntity
  alias Aquebra.Logistic.DonorEntity
  alias RoutePlanner
  alias RouteCalculator
  alias Aquebra.Genetic.EntityCoordinate
  alias Aquebra.Genetic.LocationCollect
  alias Aquebra.Genetic.LocationDeliver

  def get_best_routes() do
    Logistic.list_volunteers()
    |> Enum.each(fn volunteer ->
      get_route(volunteer)
      verify_if_possible_to_get_more_routes(volunteer)
    end)
  end

  defp log_route_results(bestRoute, id) do
    Logger.info(
      "Volunteer: #{id}, Total distance: #{RouteCalculator.distance(bestRoute)}, Extra route distance: #{get_extra_distance_in_route(bestRoute)}\n Route: #{inspect(assemble_route_url(bestRoute))}}\n"
    )
  end

  defp get_route(volunteer) do
    {id, origin, destiny, collectPoints, deliverPoints} = assemble_volunteer_data(volunteer)
    bestRoute = get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints)
    log_route_results(bestRoute, id)
    url = assemble_route_url(bestRoute)
    Volunteer.apply_volunteer_match(bestRoute, volunteer, url)
  end

  defp verify_if_possible_to_get_more_routes(volunteer) do
    if should_get_another_route(volunteer) do
      get_more_routes(volunteer)
      verify_if_possible_to_get_more_routes(volunteer)
    end
  end

  defp get_more_routes(volunteer) do
    {id, origin, destiny, collectPoints, deliverPoints} = assemble_retrigger_volunteer_data(volunteer)
    bestRoute = get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints)
    log_route_results(bestRoute, id)
    url = assemble_route_url(bestRoute)
    Volunteer.apply_volunteer_match(bestRoute, volunteer, url)
  end

  defp should_get_another_route(volunteer) do
    matches = Logistic.get_match_by_volunteer_id(volunteer.id)

    total_donation_quantity =
      Enum.reduce(matches, 0, fn match, acc ->
        acc = acc + match.quantity
      end)

    if total_donation_quantity < volunteer.vehicleCapacity && are_donations_left_in_donor_entity(matches) do
      true
    else
      false
    end
  end

  defp are_donations_left_in_donor_entity(matches) do
    match = Enum.at(matches, 0)

    Logistic.get_stock_by_entity_id(match.donor_entity_id)
    |> Enum.any?(fn stock ->
      stock.quantity > 0
    end)
  end

  defp assemble_volunteer_data(volunteer) do
    id = volunteer.id
    origin = get_Address_Coordinates(volunteer.originAddressId)
    destiny = get_Address_Coordinates(volunteer.destinyAddressId)
    collectPoints = get_collect_points_from_stock()
    deliverPoints = get_deliver_points_from_needed_donation()
    {id, origin, destiny, collectPoints, deliverPoints}
  end

  defp assemble_retrigger_volunteer_data(volunteer) do
    id = volunteer.id
    origin = get_Address_Coordinates(volunteer.originAddressId)
    destiny = get_Address_Coordinates(volunteer.destinyAddressId)
    collectPoints = get_collect_points_from_match(volunteer.id)
    deliverPoints = get_deliver_points_from_match(volunteer.id)
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

  defp get_collect_points_from_match(volunteer_id) do
    Logistic.get_match_by_volunteer_id(volunteer_id)
    |> Enum.map(fn match ->
      Logistic.get_stock_by_entity_id(match.donor_entity_id)
    end)
    |> Enum.at(0)
    |> Enum.map(fn stock ->
      stock
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

  defp get_deliver_points_from_match(volunteer_id) do
    Logistic.get_match_by_volunteer_id(volunteer_id)
    |> Enum.map(fn match ->
      Logistic.get_needed_donation!(match.receiving_entity_id)
    end)
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

  defp get_Volunteer_Best_Route(origin, destiny, collectPoints, deliverPoints) do
    RoutePlanner.execute(origin, destiny, collectPoints, deliverPoints)
  end

  defp get_coordinate_field(entity_tuples) do
    entity_tuples
    |> Enum.map(fn tuple ->
      {entity, coordinate} = tuple
      coordinate
    end)
  end

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

  defp assemble_route_url(route) do
    [startPoint, collectPoint, deliverPoint, endPoint] = [
      route.start_point,
      route.collect_point.entity_position,
      route.deliver_point.entity_position,
      route.end_point
    ]

    {start_lat, start_lon} = startPoint
    {collect_lat, collect_lon} = collectPoint
    {deliver_lat, deliver_lon} = deliverPoint
    {end_lat, end_lon} = endPoint

    url =
      "https://www.google.com.br/maps/dir/#{start_lat},+#{start_lon}/#{collect_lat},+#{collect_lon}/#{deliver_lat},+#{deliver_lon}/#{end_lat},+#{end_lon}"

    url
  end
end
