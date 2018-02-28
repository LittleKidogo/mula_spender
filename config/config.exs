# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configure Ueberauth OAuth
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]}
  ]

# configure Guardian for Session Handling
config :spender, Spender.Auth.Guardian,
  issuer: "LittleKidogo",
  secret_key: System.get_env("MIX_SECRET")

# configure Google Sign In Strategy for Ueberauth
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# General application configuration
config :spender,
  ecto_repos: [Spender.Repo]

# Configures the endpoint
config :spender, SpenderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2hzBoOeLgWfnFQ0kiEMPz3yLS0+f2GUx1HmCp/zJd9p7dyU1gdAGVWsJjyGTGTon",
  render_errors: [view: SpenderWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Spender.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
