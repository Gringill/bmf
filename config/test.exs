use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :aws_lightsail, AwsLightsailWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :aws_lightsail, AwsLightsail.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "aws_lightsail_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
