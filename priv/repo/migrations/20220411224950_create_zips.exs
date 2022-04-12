defmodule ApiSolfacil.Repo.Migrations.CreateZips do
  use Ecto.Migration

  def change do
    create table(:zips) do
      add :cep, :string
      add :bairro, :string, null: true
      add :complemento, :string, null: true
      add :logradouro, :string, null: true
      add :localidade, :string, null: true
      add :uf, :string, null: true
      add :ibge, :string, null: true
      add :gia, :string, null: true
      add :ddd, :string, null: true
      add :siafi, :string, null: true

      timestamps()
    end
  end
end
