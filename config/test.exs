use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :super_api, SuperApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :super_api, SuperApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("TEST_DATABASE_USERNAME"),
  password: System.get_env("TEST_DATABASE_PASSWORD"),
  database: "super_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :bcrypt_elixir, :log_rounds, 4