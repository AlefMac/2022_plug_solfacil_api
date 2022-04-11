defmodule ApiSolfacil.Repo do
  use Ecto.Repo,
    otp_app: :api_solfacil,
    adapter: Ecto.Adapters.Postgres
end
