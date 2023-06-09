import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ausbildungsnachweisdigital, Ausbildungsnachweisdigital.Repo,
  username: "sjm",
  password: "postgres",
  hostname: "localhost",
  database: "ausbildungsnachweisdigital_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ausbildungsnachweisdigital, AusbildungsnachweisdigitalWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "6IMt8uxV8SZyP8RU/RLHoUWP1Hc93f9ivTavV8QIRGnQCLHSiKGz+4D6k0Jofcvl",
  server: false

# In test we don't send emails.
config :ausbildungsnachweisdigital, Ausbildungsnachweisdigital.Mailer,
  adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
