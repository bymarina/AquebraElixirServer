defmodule Aquebra.Repo.Migrations.CreateNeededdonations do
  use Ecto.Migration

  def change do
    create table(:neededdonations) do
      add :type, :string
      add :quantity, :integer
      add :day, :string

      timestamps()
    end
  end
end
