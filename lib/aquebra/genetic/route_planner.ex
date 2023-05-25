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
    population_size = 5
    max_generations = 100
    mutation_rate = 0.02

    planner = %RoutePlan{
      population_size: population_size,
      max_generations: max_generations,
      mutation_rate: mutation_rate,
      collectPoints: collectPoints,
      deliverPoints: deliverPoints,
      start_point: start_point,
      end_point: end_point
    }

    population = initialize_population(planner)
    initial_best_route = get_best_route(population)
    #IO.puts("Starting Best Route: #{inspect(initial_best_route.route)}")

    best_population = Enum.reduce(1..max_generations, population, fn generation, acc ->
        new_population = evolve_population(acc, planner)
        best_route = get_best_route(new_population)

        #IO.puts("Generation: #{generation}, Best Route Distance: #{RouteCalculator.distance(best_route)}")

        new_population
      end)

    best_route = get_best_route(best_population)
#    IO.puts("Final Best Route: #{inspect(best_route.route)}")
#    IO.puts("Best Route Distance: #{RouteCalculator.distance(best_route)}")
#    best_route
  end

  defp initialize_population(planner) do
    Enum.map(1..planner.population_size, fn _ ->
      RouteCalculator.generate_random(planner.collectPoints, planner.deliverPoints, planner.start_point, planner.end_point)
    end)
  end

  defp evolve_population(population, planner) do
    elite_size = 2
    elite = get_elite(population, elite_size)
    children = crossover_population(population, elite_size)
    mutated_children = mutate_population(children, planner)

    elite ++ mutated_children
  end

  defp get_elite(population, elite_size) do
    population
    |> Enum.sort_by(&RouteCalculator.distance/1)
    |> Enum.take(elite_size)
  end

  defp get_best_route(population) do
    Enum.min_by(population, &RouteCalculator.distance/1)
  end

  defp crossover_population(population, elite_size) do
    children =
      Enum.map(1..(length(population) - elite_size), fn _ ->
        parent1 = select_parent(population)
        parent2 = select_parent(population)

        crossover(parent1, parent2)
      end)

    children
  end

  defp select_parent(population) do
    Enum.random(population)
  end

  defp crossover(parent1, parent2) do
    genes1 = parent1.route
    genes2 = parent2.route

    [startPoint1, collectPoint_parent1, deliverPoint_parent1, endPoint1] = genes1
    [startPoint2, collectPoint_parent2, deliverPoint_parent2, endPoint2] = genes2

    collectPoint = if :random.uniform() < 0.5, do: collectPoint_parent2, else: collectPoint_parent1
    deliverPoint = if :random.uniform() < 0.5, do: deliverPoint_parent2, else: deliverPoint_parent1

    selected_genes = [startPoint1, collectPoint, deliverPoint, endPoint1]
    %Route{route: selected_genes}
  end


  defp mutate_population(children, planner) do
    Enum.map(children, fn child ->
      mutate(child, planner)
    end)
  end

  defp mutate(child, planner) do
    genes = child.route

    [startPoint, collectPoint_parent, deliverPoint_parent, endPoint] = genes

    Enum.each(1..2, fn i ->
      if :random.uniform() < planner.mutation_rate do
        {selected_genes, remaining_genes} = Enum.split(genes, i)

        collectPoint = List.last(selected_genes)
        deliverPoint = List.first(remaining_genes)

        {new_collectPoint, new_deliverPoint} = generate_mutated_points(collectPoint, deliverPoint, planner)

        collectPoint = if :random.uniform() < 0.5, do: new_collectPoint, else: collectPoint
        deliverPoint = if :random.uniform() < 0.5, do: new_deliverPoint, else: deliverPoint

        mutated_genes = [startPoint, collectPoint, deliverPoint, endPoint]

        genes = mutated_genes
      end
    end)

    %Route{route: genes}
  end

  defp generate_mutated_points(collectPoint, deliverPoint, planner) do
    possible_collectPoints = planner.collectPoints
    possible_deliverPoints = planner.deliverPoints

    new_collectPoint = Enum.random(possible_collectPoints)
    new_deliverPoint = Enum.random(possible_deliverPoints)

    {new_collectPoint, new_deliverPoint}
  end

end