defmodule ApiSolfacil.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiSolfacil.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        nick_name: "some nick_name",
        password: "some password"
      })
      |> ApiSolfacil.Accounts.create_user()

    user
  end
end
