defmodule Aquebra.Logistic.Donation_evaluation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "donations_evaluation" do
    field :match_ids, :string
    field :total_available, :float
    field :total_donated, :float
    field :donor_entity_id, :id

    timestamps()
  end

  @doc false
  def changeset(donation_evaluation, attrs) do
    donation_evaluation
    |> cast(attrs, [:total_available, :total_donated, :match_ids])
    |> validate_required([:total_available, :total_donated, :match_ids])
  end
end
