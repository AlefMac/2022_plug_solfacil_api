defmodule ApiSolfacilWeb.SessionPlug do
  import Plug.Conn
  import ApiSolfacilWeb.VerifyKeyToken
  
  use Joken.Config

  alias ApiSolfacil.Accounts

  def init(default), do: default

  def call(%Plug.Conn{} = conn, _default) do
    headers = conn.req_headers
    {_, token} = verify_key(headers)

    token = String.replace(token, "Bearer", "") |> String.trim()

    find_token = Accounts.get_token(token)

    case find_token do
      nil ->
        body = %{
          "status" => false,
          "message" => "Você não tem permissão para acessar essa rota"
        }

        send_resp(conn, 401, Jason.encode!(body))

      _ ->
        assign(conn, :ok, "pass authorized")
    end
  end
end
