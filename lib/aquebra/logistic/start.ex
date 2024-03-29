defmodule Aquebra.Logistic.Start do
  alias Aquebra.Logistic.Match
  alias Aquebra.Logistic.Stock
  alias Aquebra.Logistic.DefineRoutes
  alias Aquebra.Logistic.Demand_evaluation
  alias Aquebra.Logistic.Donation_evaluation
  alias Aquebra.Logistic.Volunteer_evaluation

  def start_algorithm() do
    prepare_match_table()
    prepare_stock_table()
    find_routes()
    evaluate_results()
  end

  def start_algorithm_one_volunteer(volunteer_id) do
    prepare_match_table()
    prepare_stock_table()
    find_routes_specific_volunteer(volunteer_id)
    evaluate_results()
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

  defp find_routes_specific_volunteer(volunteer_id) do
    DefineRoutes.get_routes_for_specific_volunteer(volunteer_id)
  end

  defp evaluate_results() do
    demand_evaluation()
    donation_evaluation()
    volunteer_evaluation()
  end

  defp demand_evaluation() do
    Demand_evaluation.clean_demand_evaluation()
    Demand_evaluation.evaluate_demand_service()
  end

  defp donation_evaluation() do
    Donation_evaluation.clean_donation_evaluation()
    Donation_evaluation.evaluate_donation_service()
  end

  defp volunteer_evaluation() do
    Volunteer_evaluation.clean_volunteer_evaluation()
    Volunteer_evaluation.evaluate_volunteer_service()
  end
end
