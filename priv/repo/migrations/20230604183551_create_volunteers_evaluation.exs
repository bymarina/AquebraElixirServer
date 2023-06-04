defmodule Aquebra.Repo.Migrations.CreateVolunteersEvaluation do
  use Ecto.Migration

  def change do
    create table(:volunteers_evaluation) do
      add :total_capacity, :float
      add :used_capacity, :float
      add :extra_distance, :float
      add :match_ids, :string
      add :volunteer_id, references(:volunteers, on_delete: :nothing)

      timestamps()
    end

    create index(:volunteers_evaluation, [:volunteer_id])
  end
end
