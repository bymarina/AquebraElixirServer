defmodule Aquebra.Logistic.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :cep, :string
    field :complement, :string
    field :coordinates, :string
    field :number, :integer
    field :street, :string

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:cep, :number, :street, :complement, :coordinates])
    |> validate_required([:cep, :number, :street, :complement, :coordinates])
  end
end
