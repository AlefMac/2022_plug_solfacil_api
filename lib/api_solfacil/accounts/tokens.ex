defmodule ApiSolfacil.Accounts.Tokens do
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "token" do
      field :email_id, :id
      field :token, :string
  
      timestamps()
    end
  
    @doc false
    def changeset(tokens, attrs) do
      tokens
      |> cast(attrs, [:email_id, :token])
      |> validate_required([:email_id, :token])
    end
  end
  