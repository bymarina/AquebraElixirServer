defmodule Aquebra.Logistic.Volunteer_evaluation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "volunteers_evaluation" do
    field :extra_distance, :float
    field :match_ids, :string
    field :total_capacity, :float
    field :used_capacity, :float
    field :volunteer_id, :id

    timestamps()
  end

  @doc false
  def changeset(volunteer_evaluation, attrs) do
    volunteer_evaluation
    |> cast(attrs, [:total_capacity, :used_capacity, :extra_distance, :match_ids])
    |> validate_required([:total_capacity, :used_capacity, :extra_distance, :match_ids])
  end
end
