defmodule Aquebra.Repo.Migrations.IncludeFirebaseIdAtUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :firebaseId, :string
    end

    create index(:users, [:firebaseId], unique: true)
  end
end
