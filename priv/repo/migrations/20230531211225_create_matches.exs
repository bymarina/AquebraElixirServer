defmodule Aquebra.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :type, :string
      add :quantity, :float
      add :donor_entity_id, references(:donorentities, on_delete: :nothing)
      add :receiving_entity_id, references(:receivingentities, on_delete: :nothing)
      add :volunteer_id, references(:volunteers, on_delete: :nothing)
      add :stock_id, references(:stocks, on_delete: :nothing)

      timestamps()
    end

    create index(:matches, [:donor_entity_id])
    create index(:matches, [:receiving_entity_id])
    create index(:matches, [:volunteer_id])
    create index(:matches, [:stock_id])
  end
end
