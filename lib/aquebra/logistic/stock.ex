defmodule Aquebra.Logistic.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do
    field :quantity, :float
    field :type, :string
    field :donorEntityId, :id

    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:type, :quantity])
    |> validate_required([:type, :quantity])
  end
end
