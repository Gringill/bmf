# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :bmf_server, BmfServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IYWEsQIIoNbr9oS+nGqsyH/jE2HvnqbiHRZX1xQNZecE5m6MwOpqV6vMd+OnJGJc",
  render_errors: [view: BmfServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BmfServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
