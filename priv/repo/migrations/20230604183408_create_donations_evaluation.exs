defmodule Aquebra.Repo.Migrations.CreateDonationsEvaluation do
  use Ecto.Migration

  def change do
    create table(:donations_evaluation) do
      add :total_available, :float
      add :total_donated, :float
      add :match_ids, :string
      add :donor_entity_id, references(:donorentities, on_delete: :nothing)

      timestamps()
    end

    create index(:donations_evaluation, [:donor_entity_id])
  end
end
