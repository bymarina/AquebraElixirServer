defmodule Aquebra.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :cep, :string
      add :number, :integer
      add :street, :string
      add :complement, :string
      add :coordinates, :string

      timestamps()
    end
  end
end
