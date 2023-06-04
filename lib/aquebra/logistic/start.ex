defmodule Aquebra.Logistic.Start do
  alias Aquebra.Logistic.Match
  alias Aquebra.Logistic.Stock
  alias Aquebra.Logistic.DefineRoutes

  def start_algorithm() do
    prepare_match_table()
    prepare_stock_table()
    find_routes()
  end

  defp prepare_stock_table() do
    Stock.clean_stock()
    Stock.start_stock()
  end

  defp prepare_match_table() do
    Match.clean_matches()
  end

  defp find_routes() do
    DefineRoutes.get_best_routes()
  end
end
