use Mix.Config

# Database configuration
config :create_fun, CreateFun.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "create_fun_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
