use Mix.Config

config :create_fun, ecto_repos: [CreateFun.Repo]

import_config "#{Mix.env}.exs"
