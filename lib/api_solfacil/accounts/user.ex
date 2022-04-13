defmodule ApiSolfacil.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Pbkdf2

  schema "users" do
    field :email, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    attrs = attrs |> hash_password
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email, name: :email)
  end

  defp hash_password(attrs) when is_map_key(attrs, "password"), do: Map.put(attrs, "password", hash_pwd_salt(attrs["password"]))

  defp hash_password(attrs), do: attrs
end
