# https://hexdocs.pm/distillery/configuration.html

Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
  default_release: :default,
  default_environment: Mix.env()

environment :dev do
  set(dev_mode: true)
  set(include_erts: false)
  set(cookie: :"_bjOc?/(8VXfkL)b(R_$eD[fknWOO%;=4c{[^P}H=gs0$sj<7]k1@fo<DCBK(1{A")
end

environment :prod do
  set(include_erts: true)
  set(include_src: false)
  set(cookie: :"Evo$iD2&Jg.nS/:`0)Ls<|M3Gd;DGgY*^V=?S|@;*wFU=fkm~^Q,CXaVT:nR&4fL")
end

release :bmf_client do
  set(version: current_version(:bmf_client))

  set(
    applications: [
      :runtime_tools
    ]
  )
end
