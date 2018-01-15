defmodule BmfClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bmf_client,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # `mix help compile.app`
  def application do
    [
      mod: {BmfClient.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # `mix help deps`
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:distillery, "~> 1.0", runtime: false},
      {:gettext, "~> 0.0"},
      {:phoenix, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:phoenix_pubsub, "~> 1.0"}
    ]
  end
end
