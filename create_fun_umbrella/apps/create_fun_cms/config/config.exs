# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :create_fun_cms,
  namespace: CreateFunCms,
  ecto_repos: [CreateFun.Repo]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :create_fun_cms, :generators,
  context_app: :create_fun

config :create_fun_cms, CreateFunCms.Auth.Pipeline.Access,
  module: CreateFun.Guardian,
  error_handler: CreateFunCms.Auth.ErrorHandler

config :create_fun_cms, CreateFunCms.Auth.Pipeline.Auth,
  module: CreateFun.Guardian,
  error_handler: CreateFunCms.Auth.ErrorHandler

config :create_fun_cms, CreateFunCms.Auth.Pipeline.Reset,
  module: CreateFun.Guardian,
  error_handler: CreateFunCms.Auth.ErrorHandler
config :create_fun_cms, CreateFunCms.Auth.Pipeline.ResetCallback,
  module: CreateFun.Guardian,
  error_handler: CreateFunCms.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
