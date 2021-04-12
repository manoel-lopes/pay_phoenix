# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pay_phoenix,
  ecto_repos: [PayPhoenix.Repo]

# Configures the endpoint
config :pay_phoenix, PayPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DC7/M+SZVMUKNuEbkvfxkEfa1CU9IxXmjeeYTMBa8eBO7q7Fj7dBUvIvuBKxKZW+",
  render_errors: [view: PayPhoenixWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PayPhoenix.PubSub,
  live_view: [signing_salt: "mHW1k4l1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
