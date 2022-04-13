defmodule ApiSolfacil.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password, :string

      timestamps()
    end

    create unique_index(:users, [:email], name: :email)

    create table(:token) do
      add :email_id, references(:users)
      add :token, :string

      timestamps()
    end
  end
end
