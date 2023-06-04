defmodule Aquebra.Repo.Migrations.CreateDemandsEvaluation do
  use Ecto.Migration

  def change do
    create table(:demands_evaluation) do
      add :total_demand, :float
      add :received_donation, :float
      add :match_ids, :string
      add :receiving_entity_id, references(:receivingentities, on_delete: :nothing)

      timestamps()
    end

    create index(:demands_evaluation, [:receiving_entity_id])
  end
end
