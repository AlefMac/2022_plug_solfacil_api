defmodule ApiSolfacil.Zips.Zip do
  use Ecto.Schema
  import Ecto.Changeset

  schema "zips" do
    field :complemento, :string, null: true
    field :ddd, :string, null: true
    field :logradouro, :string, null: true
    field :gia, :string, null: true
    field :ibge, :string, null: true
    field :localidade, :string, null: true
    field :bairro, :string, null: true
    field :siafi, :string, null: true
    field :uf, :string, null: true
    field :cep, :string, null: true

    timestamps()
  end

  @doc false
  def changeset(zip, attrs) do
    zip
    |> cast(attrs, [
      :cep,
      :bairro,
      :complemento,
      :logradouro,
      :localidade,
      :uf,
      :ibge,
      :gia,
      :ddd,
      :siafi
    ])
    |> validate_required([:cep, :bairro, :uf, :ibge, :ddd])
  end
end
