defmodule Aquebra.Repo.Migrations.CreateVolunteers do
  use Ecto.Migration

  def change do
    create table(:volunteers) do
      add :name, :string
      add :vehicleCapacity, :integer
      add :picture, :string
      add :userId, references(:users, on_delete: :nothing)
      add :documentNumberId, references(:documents, on_delete: :nothing)
      add :OriginAddressId, references(:addresses, on_delete: :nothing)
      add :DestinyAddressId, references(:addresses, on_delete: :nothing)

      timestamps()
    end

    create index(:volunteers, [:userId])
    create index(:volunteers, [:documentNumberId])
    create index(:volunteers, [:OriginAddressId])
    create index(:volunteers, [:DestinyAddressId])
  end
end
