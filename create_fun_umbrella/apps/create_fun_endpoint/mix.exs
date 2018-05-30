defmodule CreateFunEndpoint.Mixfile do
  use Mix.Project

  def project do
    [
      app: :create_fun_endpoint,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: (Mix.env == :prod || Mix.env == :staging),
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {CreateFunEndpoint.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :create_fun,
        :create_fun_api, #YipYip-Scaffold-Remove-API
        :create_fun_cms, #YipYip-Scaffold-Remove-CMS
        :create_fun_web #YipYip-Scaffold-Remove-WEB
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.2"},
      {:phoenix_pubsub, "1.0.2"},
      {:phoenix_ecto, "3.3.0"},
      {:phoenix_html, "2.10.5"},
      {:phoenix_live_reload, "1.1.3", only: :dev},
      {:gettext, "0.14.1"},
      {:cowboy, "~> 1.0.0"},
      {:create_fun, in_umbrella: true},
      {:create_fun_api, in_umbrella: true}, #YipYip-Scaffold-Remove-API
      {:create_fun_cms, in_umbrella: true}, #YipYip-Scaffold-Remove-CMS
      {:create_fun_web, in_umbrella: true} #YipYip-Scaffold-Remove-WEB
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, we extend the test task to create and migrate the database.
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end