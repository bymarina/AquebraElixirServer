defmodule Aquebra.Logistic.Demand_evaluation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Aquebra.Logistic
  alias Aquebra.Logistic.ReceivingEntity
  alias Aquebra.Logistic.Match
  alias Aquebra.Logistic.NeededDonation

  schema "demands_evaluation" do
    field :match_ids, :string
    field :received_donation, :float
    field :total_demand, :float
    field :receiving_entity_id, :id

    timestamps()
  end

  @doc false
  def changeset(demand_evaluation, attrs) do
    demand_evaluation
    |> cast(attrs, [:total_demand, :received_donation, :match_ids, :receiving_entity_id])
    |> validate_required([:total_demand, :received_donation, :receiving_entity_id])
  end

  def evaluate_demand_service() do
    Logistic.list_receivingentities()
    |> Enum.each(fn entity ->
      initial_demand = get_initial_demand(entity.id)
      total_donation_received = get_total_donation_received(entity.id)
      match_list = get_match_id_list(entity.id)

      evaluation_params = %{
        total_demand: initial_demand,
        received_donation: total_donation_received,
        match_ids: match_list,
        receiving_entity_id: entity.id
      }

      Logistic.create_demand_evaluation(evaluation_params)
    end)
  end

  defp get_initial_demand(entity_id) do
    Logistic.get_needed_donation_by_entity_id(entity_id)
    |> Enum.reduce(0, fn demand, acc ->
      acc = acc + demand.quantity
    end)
  end

  defp get_total_donation_received(entity_id) do
    Logistic.get_match_by_receiving_entity_id(entity_id)
    |> Enum.reduce(0, fn donation, acc ->
      acc = acc + donation.quantity
    end)
  end

  defp get_match_id_list(entity_id) do
    Logistic.get_match_by_receiving_entity_id(entity_id)
    |> Enum.map(fn match ->
      match.id
    end)
    |> Enum.join(",")
  end

  def clean_demand_evaluation() do
    Logistic.delete_all_demand_evaluation()
  end
end
