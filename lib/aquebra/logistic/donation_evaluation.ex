defmodule Aquebra.Logistic.Donation_evaluation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Aquebra.Logistic

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
    |> cast(attrs, [:total_available, :total_donated, :match_ids, :donor_entity_id])
    |> validate_required([:total_available, :total_donated, :donor_entity_id])
  end

  def evaluate_donation_service() do
    Logistic.list_donorentities()
    |> Enum.each(fn donor_entity ->
      total_available = get_total_donation_available(donor_entity.id)
      total_donated = get_total_donated(donor_entity.id)
      match_ids_list = get_match_ids(donor_entity.id)
      donor_entity_id = donor_entity.id

      evaluation_params = %{
        total_available: total_available,
        total_donated: total_donated,
        match_ids: match_ids_list,
        donor_entity_id: donor_entity_id
      }

      Logistic.create_donation_evaluation(evaluation_params)
    end)
  end

  defp get_total_donation_available(entity_id) do
    Logistic.get_donation_id_from_entity_id(entity_id)
    |> Enum.reduce(0, fn donation, acc ->
      donation_product = Logistic.get_donation_product!(donation.donationId)
      acc = acc + donation_product.quantity
    end)
  end

  defp get_total_donated(entity_id) do
    Logistic.get_match_by_donor_entity_id(entity_id)
    |> Enum.reduce(0, fn match, acc ->
      acc = acc + match.quantity
    end)
  end

  defp get_match_ids(entity_id) do
    Logistic.get_match_by_donor_entity_id(entity_id)
    |> Enum.map(fn match ->
      match.id
    end)
    |> Enum.join(",")
  end

  def clean_donation_evaluation() do
    Logistic.delete_all_donation_evaluation()
  end
end
