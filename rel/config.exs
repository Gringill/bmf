# https://hexdocs.pm/distillery/configuration.html
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"]j~*J8*rQV~aqH|/$D@hg^fCFeO}TawM*]BZ>=7L7$%XLKk]f,9oo4}Z_urT/F0j"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"JtGd,LQ]8[gG&9PwYV1,OR({Uk>!v`j@4WRkJm2l.u4*CGQ|4J$G,vj$zu.}m&8J"
end

release :aws_lightsail do
  set version: current_version(:aws_lightsail)
  set applications: [
    :runtime_tools
  ]
  plugin ReleaseToTmp
end

