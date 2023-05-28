# defmodule Aquebra.Genetic.RouteCalculator do
defmodule RouteCalculator do
  alias Aquebra.Genetic.Route

  def generate_random(collectPoints, deliverPoints, start_point, end_point) do
    gene = [start_point] ++ [Enum.random(collectPoints)] ++ [Enum.random(deliverPoints)] ++ [end_point]
    %Route{route: gene}
    # |> IO.inspect()
  end

  def distance(route) do
    route_start = Enum.at(route.route, 0)
    acc = {0, route_start}

    Enum.reduce(route.route, acc, fn point, {distance, prev_point} ->
      new_distance = distance + calculate_distance(prev_point, point)
      {new_distance, point}
    end)
    |> elem(0)
  end

  def calculate_distance(point1, point2) do
    distance = Geocalc.distance_between(point1, point2) / 1000.0
    distance
  end
end
