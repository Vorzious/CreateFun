use Mix.Config

# Database configuration
config :create_fun, CreateFun.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USERNAME"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: System.get_env("POSTGRES_DATABASE"),
  hostname: System.get_env("POSTGRES_HOSTNAME"),
  pool_size: 10
