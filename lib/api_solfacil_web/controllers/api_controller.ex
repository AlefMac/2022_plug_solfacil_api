defmodule ApiSolfacilWeb.ApiController do
  use Phoenix.Controller
  use Joken.Config

  import ApiSolfacilWeb.VerifyKeyToken

  alias ApiSolfacil.Zips
  alias ApiSolfacil.Zips.Zip

  plug ApiSolfacilWeb.SessionPlug when action in [:show, :upload]

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

  def upload(conn, _params) do
    headers = conn.req_headers
    {_, token} = verify_key(headers)

    token = String.replace(token, "Bearer", "") |> String.trim()

    {:ok, info} = Joken.Signer.verify(token, Joken.Signer.create("HS256", "secret"))

    email = info["email"]

    json(conn, %{"status" => true, "message" => "Enviado com sucesso"})
  end

  # defp decode_token() do
  
  # end
end
