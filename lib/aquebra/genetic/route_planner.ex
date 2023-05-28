defmodule RoutePlanner do
  alias Aquebra.Genetic.Route

  def execute(start_point, end_point) do
    collectPoints = [
      {-25.401236870700316, -49.24885639467048},
      {-25.450927415975382, -49.28018371775742},
      {-25.428853537996982, -49.22946848726456},
      {-25.439323927044583, -49.282618851899876}
    ]

    deliverPoints = [
      {-25.377790611861027, -49.26166571654154},
      {-25.385244237604923, -49.232630444120716},
      {-25.417648384306904, -49.24295494493716},
      {-25.510155174862906, -49.294898077339646},
      {-25.43546539567159, -49.272521031800764}
    ]

    #    start_point = {-25.479718797938826, -49.28659032337815}
    #    end_point = {-25.431311936507075, -49.273607916790056}

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
    IO.puts("Best Route Distance: #{inspect(best_route.fitness)}")
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

    IO.puts(
      "[#{best_route.fitness}] Generation: #{generation}, Best Route Distance: #{RouteCalculator.distance(best_route)}"
    )

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
