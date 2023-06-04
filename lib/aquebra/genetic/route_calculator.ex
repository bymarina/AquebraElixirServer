# defmodule Aquebra.Genetic.RouteCalculator do
defmodule RouteCalculator do
  alias Aquebra.Genetic.Route

  def generate_random(collectPoints, deliverPoints, start_point, end_point) do
    #    gene = [start_point] ++ [Enum.random(collectPoints)] ++ [Enum.random(deliverPoints)] ++ [end_point]
    #    %Route{route: gene}
    # :route, :fitness, :start_point, :collect_point, :deliver_point, :end_point
    %Route{
      start_point: start_point,
      collect_point: Enum.random(collectPoints),
      deliver_point: Enum.random(deliverPoints),
      end_point: end_point
    }
  end

  def distance(gene) do
    gene
    route = [gene.start_point, gene.collect_point.entity_position, gene.deliver_point.entity_position, gene.end_point]
    route_start = Enum.at(route, 0)
    acc = {0, route_start}

    Enum.reduce(route, acc, fn point, {distance, prev_point} ->
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
