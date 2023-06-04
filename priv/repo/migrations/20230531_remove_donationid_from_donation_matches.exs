defmodule Aquebra.Repo.Migrations.UpdateMatchesTable do
  use Ecto.Migration

  def change do
    alter table(:donationmatches) do
      remove :donorEntityDonationId
    end
  end
end
