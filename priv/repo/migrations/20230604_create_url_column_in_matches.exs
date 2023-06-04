defmodule Aquebra.Repo.Migrations.CreateUrlInMatches do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :url, :string
    end
  end
end
