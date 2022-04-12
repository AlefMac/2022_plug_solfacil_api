defmodule ApiSolfacil.ZipsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiSolfacil.Zips` context.
  """

  @doc """
  Generate a zip.
  """
  def zip_fixture(attrs \\ %{}) do
    {:ok, zip} =
      attrs
      |> Enum.into(%{
        complement: "some complement",
        ddd: "some ddd",
        district: "some district",
        gia: "some gia",
        ibge: "some ibge",
        locality: "some locality",
        public_place: "some public_place",
        siafi: "some siafi",
        uf: "some uf",
        zip_code: "some zip_code"
      })
      |> ApiSolfacil.Zips.create_zip()

    zip
  end
end
