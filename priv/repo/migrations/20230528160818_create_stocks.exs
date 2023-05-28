defmodule Aquebra.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :type, :string
      add :quantity, :float
      add :donorEntityId, references(:donorentities, on_delete: :nothing)

      timestamps()
    end

    create index(:stocks, [:donorEntityId])
  end
end
