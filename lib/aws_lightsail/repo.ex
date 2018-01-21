defmodule AwsLightsail.Repo do
  use Ecto.Repo, otp_app: :aws_lightsail

  def init(_, compiled_config) do
    config =
      if compiled_config[:load_from_system_env] do
        runtime_config = [
          url: system_get_env("DB_URL"),
          pool_size: system_get_env("DB_POOL_SIZE")
        ]

        Keyword.merge(compiled_config, runtime_config)
      else
        compiled_config
      end

    {:ok, config}
  end

  defp system_get_env(var),
    do: System.get_env(var) || raise("expected the #{var} environment variable to be set")
end
