defmodule Aquebra.Logistic.Demand_evaluation do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> cast(attrs, [:total_demand, :received_donation, :match_ids])
    |> validate_required([:total_demand, :received_donation, :match_ids])
  end
end
