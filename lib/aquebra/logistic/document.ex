defmodule Aquebra.Logistic.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :number, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:type, :number])
    |> validate_required([:type, :number])
  end
end
