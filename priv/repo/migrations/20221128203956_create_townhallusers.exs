defmodule Aquebra.Repo.Migrations.CreateTownhallusers do
  use Ecto.Migration

  def change do
    create table(:townhallusers) do
      add :name, :string
      add :userId, references(:users, on_delete: :nothing)
      add :documentNumberId, references(:documents, on_delete: :nothing)
      add :AddressId, references(:addresses, on_delete: :nothing)

      timestamps()
    end

    create index(:townhallusers, [:userId])
    create index(:townhallusers, [:documentNumberId])
    create index(:townhallusers, [:AddressId])
  end
end
