defmodule ApiSolfacilWeb.ApiController do
  use Phoenix.Controller

  alias ApiSolfacil.Zips
  alias ApiSolfacil.Zips.Zip

  @url_find_cep Application.get_env(:ulr_api, :find_cep)

  def show(conn, %{"zip" => zip_code}) do
    zip = Zips.get_zip(zip_code)

    case zip do
      %Zip{} ->
        struct = zip |> Map.from_struct() |> Map.drop([:__meta__, :inserted_at, :updated_at, :id])
        json(conn, struct)

      _ ->
        link = @url_find_cep <> zip_code <> "/json"
        response = HTTPoison.get!(link)
        resp = Jason.decode!(response.body)
        formatter_cep = String.replace(resp["cep"], "-", "")
        resp 
        |> Map.put("cep", formatter_cep)
        |> Zips.create_zip()
        
        json(conn, resp)
    end
  end
end
