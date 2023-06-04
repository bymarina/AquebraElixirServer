defmodule Aquebra.Logistic.Volunteer_evaluation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Aquebra.Logistic

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
    |> cast(attrs, [:total_capacity, :used_capacity, :extra_distance, :match_ids, :volunteer_id])
    |> validate_required([:total_capacity, :used_capacity, :extra_distance])
  end

  def evaluate_volunteer_service() do
    # [:total_capacity, :used_capacity, :extra_distance, :match_ids, :volunteer_id]
    Logistic.list_volunteers()
    |> Enum.each(fn volunteer ->
      total_capacity = volunteer.vehicleCapacity
      used_capacity = get_total_volunteer_used_capacity(volunteer.id)
      extra_distance = get_match_extra_distance(volunteer.id)
      match_ids_list = get_match_ids(volunteer.id)

      evaluation_params = %{
        total_capacity: total_capacity,
        used_capacity: used_capacity,
        extra_distance: extra_distance,
        match_ids: match_ids_list,
        volunteer_id: volunteer.id
      }

      Logistic.create_volunteer_evaluation(evaluation_params)
    end)
  end

  defp get_total_volunteer_used_capacity(volunteer_id) do
    Logistic.get_match_by_volunteer_id(volunteer_id)
    |> Enum.reduce(0, fn match, acc ->
      acc = acc + match.quantity
    end)
  end

  defp get_match_extra_distance(volunteer_id) do
    matches = Logistic.get_match_by_volunteer_id(volunteer_id)
    match = Enum.at(matches, 0)
    match.extra_distance
  end

  defp get_match_ids(volunteer_id) do
    Logistic.get_match_by_volunteer_id(volunteer_id)
    |> Enum.map(fn match ->
      match.stock_id
    end)
    |> Enum.join(",")
  end

  def clean_volunteer_evaluation() do
    Logistic.delete_all_volunteer_evaluation()
  end
end
