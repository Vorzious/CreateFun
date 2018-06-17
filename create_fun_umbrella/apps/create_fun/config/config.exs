use Mix.Config

config :create_fun, ecto_repos: [CreateFun.Repo]

config :ueberauth, Ueberauth,
  providers: [
    identity_cms: {Ueberauth.Strategy.Identity, [
        callback_methods: ["POST"],
        param_nesting: "user",
        request_path: "/cms/auth/identity",
        callback_path: "/cms/auth/identity/callback",
        uid_field: :username,
        nickname_field: :username
    ]},
    identity_web: {Ueberauth.Strategy.Identity,[
        callback_methods: ["POST"],
        param_nesting: "user",
        request_path: "/auth/identity",
        callback_path: "/auth/identity/callback",
        uid_field: :username,
        nickname_field: :username
    ]}
  ]

config :create_fun, CreateFun.Guardian,
  issuer: "create_fun",
  secret_key: System.get_env("GUARDIAN_SECRET"),
  allowed_algos: ["HS512"],
  ttl: {30, :days},
  token_ttl: %{"access" => {1, :day}, "refresh" => {30, :days}},
  permissions: %{
    admin: [:admins, :artists],
    artist: [:index]
  }

config :guardian, Guardian.DB,
  repo: CreateFun.Repo,
  schema_name: "guardian_tokens",
  token_types: ["access", "refresh"],
  sweep_interval: 60

config :arc,
  storage: Arc.Storage.GCS,
  bucket: "create-fun-storage-bucket"

config :goth,
  json: "./apps/create_fun/config/keyfile.json" |> Path.expand() |> File.read!

import_config "#{Mix.env}.exs"
