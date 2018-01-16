defmodule ReleaseToTmp do
  use Mix.Releases.Plugin

  def before_assembly(%Release{} = release, _opts), do: release

  def after_assembly(%Release{} = release, _opts), do: release

  def before_package(%Release{} = release, _opts), do: release

  def after_package(%Release{name: name, version: version} = release, _opts) do
    source = "_build/prod/rel/#{name}/releases/#{version}/#{name}.tar.gz"
    dest = "/tmp/#{name}.tar.gz"
    File.cp!(source, dest)
    notice """
    Release copied
      source: #{source}
      dest: #{dest}
    """
    release
  end
end
