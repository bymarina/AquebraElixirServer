defmodule Aquebra.Repo.Migrations.CreateDonationproducts do
  use Ecto.Migration

  def change do
    create table(:donationproducts) do
      add :type, :string
      add :quantity, :float
      add :day, :string

      timestamps()
    end
  end
end
