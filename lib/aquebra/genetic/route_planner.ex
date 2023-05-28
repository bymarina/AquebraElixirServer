defmodule RoutePlanner do
  alias Aquebra.Genetic.Route

  def execute(start_point, end_point, collectPoints, deliverPoints) do

    solve(collectPoints, deliverPoints, start_point, end_point)
  end

  def solve(collectPoints, deliverPoints, start_point, end_point) do
    planner = %RoutePlan{
      population_size: 20,
      max_generations: 200,
      mutation_rate: 0.01,
      crossover_rate: 0.8,
      elite_percent: 0.8,
      collectPoints: collectPoints,
      deliverPoints: deliverPoints,
      start_point: start_point,
      end_point: end_point
    }

    population = initialize_population(planner)
    # initial_best_route = get_best_route(population)
    # IO.puts("Starting Best Route: #{inspect(initial_best_route.route)}")

    best_population =
      Enum.reduce(1..planner.max_generations, population, fn generation, acc ->
        evolve_population(acc, planner, generation)
      end)

    best_route = get_best_route(best_population)
    IO.puts("Final Best Route: #{inspect(best_route.route)}")
    #IO.puts("Best Route Distance: #{inspect(best_route.fitness)}")
    best_route
  end

  defp initialize_population(planner) do
    Enum.map(1..planner.population_size, fn _ ->
      RouteCalculator.generate_random(planner.collectPoints, planner.deliverPoints, planner.start_point, planner.end_point)
    end)
  end

  defp evolve_population(population, planner, generation) do
    population = fitness(population)
    best_route = Enum.at(population, 0)

#    IO.puts(
#     "[#{best_route.fitness}] Generation: #{generation}, Best Route Distance: #{RouteCalculator.distance(best_route)}"
#    )

    [selected_parents, leftover_parents] = select_by_elite(population, planner)
    children = crossover_population(selected_parents, planner)
    mutate_population(children ++ leftover_parents, planner)
  end

  defp fitness(population) do
    population
    |> Enum.map(fn gene ->
      distance = RouteCalculator.distance(gene)
      fitness = 1 / distance
      Map.put(gene, :fitness, fitness)
    end)
    |> Enum.sort_by(
      fn gene ->
        gene.fitness
      end,
      :desc
    )
  end

  defp select_by_elite(population, planner) do
    selection_number = round(length(population) * planner.elite_percent)
    selection_number = if rem(selection_number, 2) == 0, do: selection_number, else: selection_number + 1

    leftover_number = planner.population_size - selection_number

    selected_parents = Enum.take(population, selection_number)
    leftover_parents = Enum.take(population, -leftover_number)

    [selected_parents, leftover_parents]
  end

  defp get_best_route(population) do
    Enum.min_by(population, &RouteCalculator.distance/1)
  end

  defp crossover_population(parents, planner) do
    parents
    |> Enum.chunk_every(2)
    |> Enum.flat_map(fn [parent1, parent2] ->
      crossover(parent1, parent2, planner)
    end)
  end

  defp crossover(parent1, parent2, planner) do
    [startPoint, collectPoint1, deliverPoint1, endPoint] = parent1.route
    [_, collectPoint2, deliverPoint2, _] = parent2.route

    {new_collectPoint1, new_collectPoint2} = do_crossover(collectPoint1, collectPoint2, planner)

    crossover_gene1 = [startPoint, new_collectPoint1, deliverPoint1, endPoint]
    crossover_gene2 = [startPoint, new_collectPoint2, deliverPoint2, endPoint]

    [%Route{route: crossover_gene1}, %Route{route: crossover_gene2}]
  end

  defp do_crossover(collectPoint1, collectPoint2, planner) do
    if :random.uniform() < planner.crossover_rate do
      {collectPoint2, collectPoint1}
    else
      {collectPoint1, collectPoint2}
    end
  end

  defp mutate_population(children, planner) do
    Enum.map(children, fn child ->
      mutate(child, planner)
    end)
  end

  defp mutate(child, planner) do
    gene = child.route

    [startPoint, collectPoint, deliverPoint, endPoint] = gene

    {new_collectPoint, new_deliverPoint} = generate_mutated_points(planner)

    collectPoint = if :random.uniform() < planner.mutation_rate, do: new_collectPoint, else: collectPoint
    deliverPoint = if :random.uniform() < planner.mutation_rate, do: new_deliverPoint, else: deliverPoint

    mutated_gene = [startPoint, collectPoint, deliverPoint, endPoint]

    %Route{route: mutated_gene}
  end

  defp generate_mutated_points(planner) do
    possible_collectPoints = planner.collectPoints
    possible_deliverPoints = planner.deliverPoints

    new_collectPoint = Enum.random(possible_collectPoints)
    new_deliverPoint = Enum.random(possible_deliverPoints)

    {new_collectPoint, new_deliverPoint}
  end
end
