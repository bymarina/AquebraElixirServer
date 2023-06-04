defmodule Aquebra.Repo.Migrations.CreateExtraDistanceColumnInMatches do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :extra_distance, :string
    end
  end
end
