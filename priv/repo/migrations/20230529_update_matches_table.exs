defmodule Aquebra.Repo.Migrations.UpdateMatchesTable do
  use Ecto.Migration

  def change do
    alter table(:donationmatches) do
      add :donorEntityId, references(:donorentities, on_delete: :nothing)
      add :receivingEntityId, references(:receivingentities, on_delete: :nothing)
      add :quantity, :float
    end

    create index(:donationmatches, [:donorEntityId])
    create index(:donationmatches, [:receivingEntityId])
    create index(:donationmatches, [:quantity])
  end
end
