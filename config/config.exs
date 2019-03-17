# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :super_api,
  ecto_repos: [SuperApi.Repo]

# Configures the endpoint
config :super_api, SuperApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Xun37QQnPzRghx6VWzbCxtI3wTHEpewnLe8ebdVJhaIKrCnD7GtyeMQ8IdOBxpJC",
  render_errors: [view: SuperApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SuperApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
