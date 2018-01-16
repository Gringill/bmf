defmodule Mix.Tasks.DockerBuild do
  @moduledoc """
  Dynamically determines the application name and version and passes them into the `docker build` command.

      mix docker_build [--dry-run] [--tag TAG]

  `-d`, `--dry-run` return the Docker command that would otherwise have been executed

  `-t TAG`, `--tag TAG` override the tag supplied to the `docker build` command
  """

  use Mix.Task

  @shortdoc "Builds a Docker image"

  def run(args) do
    with {:ok, opts} <- process_args(args) do
      cmd = build_cmd(opts)

      cond do
        opts[:help] -> help()
        opts[:dry_run] -> Mix.Shell.IO.info(cmd)
        true -> Mix.Shell.IO.cmd(cmd, stderr_to_stdout: true)
      end
    end
  end

  defp build_cmd(opts) do
    """
    docker build \
    --build-arg APP_NAME=#{opts[:app_name]} \
    --build-arg APP_VERSION=#{opts[:app_version]} \
    -t #{opts[:tag]} \
    .\
    """
  end

  defp process_args(args) do
    config = Mix.Project.config()
    app_name = config[:app]
    app_version = config[:version]

    opts_defs = [
      dry_run: :boolean,
      tag: :string,
      help: :boolean
    ]

    aliases = [
      d: :dry_run,
      t: :tag,
      h: :help
    ]

    {raw_opts, []} = OptionParser.parse!(args, aliases: aliases, strict: opts_defs)

    default_opts = [
      app_name: app_name,
      app_version: app_version,
      dry_run: false,
      help: false,
      tag: "#{app_name}:#{app_version}"
    ]

    opts = Keyword.merge(default_opts, raw_opts)
    {:ok, opts}
  end

  defp help, do: Mix.Shell.IO.info("mix help #{Mix.Task.task_name(__MODULE__)}")
end
