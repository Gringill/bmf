use Mix.Config

config :bmf_client, BmfClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TreV5xisQVBhWGoMnkRR8dK+cyhFzv5XKfV+ISarYpFz/cPoYpexzJ5TYAkQ5MKo",
  render_errors: [view: BmfClientWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BmfClient.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env()}.exs"
