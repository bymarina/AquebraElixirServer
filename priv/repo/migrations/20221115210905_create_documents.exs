defmodule Aquebra.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :type, :string
      add :number, :string

      timestamps()
    end
  end
end
