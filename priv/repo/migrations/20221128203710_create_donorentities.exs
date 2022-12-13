defmodule Aquebra.Repo.Migrations.CreateDonorentities do
  use Ecto.Migration

  def change do
    create table(:donorentities) do
      add :name, :string
      add :businessHoursOpening, :string
      add :businessHoursClosing, :string
      add :userId, references(:users, on_delete: :nothing)
      add :documentNumberId, references(:documents, on_delete: :nothing)
      add :addressId, references(:addresses, on_delete: :nothing)

      timestamps()
    end

    create index(:donorentities, [:userId])
    create index(:donorentities, [:documentNumberId])
    create index(:donorentities, [:addressId])
  end
end
