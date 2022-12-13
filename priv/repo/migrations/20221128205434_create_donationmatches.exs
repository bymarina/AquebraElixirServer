defmodule Aquebra.Repo.Migrations.CreateDonationmatches do
  use Ecto.Migration

  def change do
    create table(:donationmatches) do
      add :donorEntityDonationId, references(:donorentitydonation, on_delete: :nothing)
      add :neededDonationId, references(:neededdonations, on_delete: :nothing)
      add :volunteerId, references(:volunteers, on_delete: :nothing)

      timestamps()
    end

    create index(:donationmatches, [:donorEntityDonationId])
    create index(:donationmatches, [:neededDonationId])
    create index(:donationmatches, [:volunteerId])
  end
end
