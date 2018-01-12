# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bmf_web,
  namespace: BmfWeb

# Configures the endpoint
config :bmf_web, BmfWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VwlBs2cQplxJXJ7ErALBYXvDmXWDlkOs6UmwH7vu8ThyW0Viz9biu5hqd7ZK+RXo",
  render_errors: [view: BmfWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BmfWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :bmf_web, :generators,
  context_app: :bmf

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
