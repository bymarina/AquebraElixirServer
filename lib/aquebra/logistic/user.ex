defmodule Aquebra.Logistic.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :type, :string
    field :firebaseId, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
