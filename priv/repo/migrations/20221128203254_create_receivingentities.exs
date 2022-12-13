defmodule Aquebra.Repo.Migrations.CreateReceivingentities do
  use Ecto.Migration

  def change do
    create table(:receivingentities) do
      add :name, :string
      add :businessHoursOpening, :string
      add :businessHoursClosing, :string
      add :userId, references(:users, on_delete: :nothing)
      add :documentNumberId, references(:documents, on_delete: :nothing)
      add :address, references(:addresses, on_delete: :nothing)

      timestamps()
    end

    create index(:receivingentities, [:userId])
    create index(:receivingentities, [:documentNumberId])
    create index(:receivingentities, [:address])
  end
end
