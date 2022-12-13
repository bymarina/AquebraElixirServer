defmodule Aquebra.Repo.Migrations.CreateDonorentitydonation do
  use Ecto.Migration

  def change do
    create table(:donorentitydonation) do
      add :donorEntityId, references(:donorentities, on_delete: :nothing)
      add :donationId, references(:donationproducts, on_delete: :nothing)

      timestamps()
    end

    create index(:donorentitydonation, [:donorEntityId])
    create index(:donorentitydonation, [:donationId])
  end
end
