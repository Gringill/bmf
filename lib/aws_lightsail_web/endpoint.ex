defmodule AwsLightsailWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :aws_lightsail

  socket("/socket", AwsLightsailWeb.UserSocket)

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug(
    Plug.Static,
    at: "/",
    from: :aws_lightsail,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)
  )

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.RequestId)
  plug(Plug.Logger)

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug(
    Plug.Session,
    store: :cookie,
    key: "_aws_lightsail_key",
    signing_salt: "GavAxPXY"
  )

  plug(AwsLightsailWeb.Router)

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, compiled_config) do
    if compiled_config[:load_from_system_env] do
      port = system_get_env("WEB_PORT")
      runtime_config = [http: [:inet6, port: port], url: [host: "example.com", port: port]]
      {:ok, Keyword.merge(compiled_config, runtime_config)}
    else
      {:ok, compiled_config}
    end
  end

  defp system_get_env(var),
    do: System.get_env(var) || raise("expected the #{var} environment variable to be set")
end
