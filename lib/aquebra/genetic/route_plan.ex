defmodule RoutePlan do
  defstruct [
    :population_size,
    :max_generations,
    :mutation_rate,
    :crossover_rate,
    :elite_percent,
    :collectPoints,
    :deliverPoints,
    :start_point,
    :end_point
  ]
end
