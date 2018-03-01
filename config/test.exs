use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :spender, SpenderWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :spender, Spender.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "spender_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox


  # configure Guardian for Session Handling
  config :spender, Spender.Auth.Guardian,
    issuer: "LittleKidogo",
    secret_key: "oWbr5lRJ/g6V6E6F0RVsrVmX0eAijegb0zOUr1iwZF3Y2eIfVHLdl/FbgsSadSD9"
