import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :api_solfacil, ApiSolfacil.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "api_solfacil_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api_solfacil, ApiSolfacilWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "CtX+VRxV060cyV5VQ8fjkLvnZO3J4pF+9ceyAChXywzawaChlj/1eos71WWMGfhQ",
  server: false

# In test we don't send emails.
config :api_solfacil, ApiSolfacil.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
