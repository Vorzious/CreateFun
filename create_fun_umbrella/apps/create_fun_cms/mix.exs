defmodule CreateFunCms.Mixfile do
  use Mix.Project

  def project do
    [
      app: :create_fun_cms,
      version: "1.0.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6.2",
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
      mod: {CreateFunCms.Application, []},
      extra_applications: [:logger, :runtime_tools]
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
      {:phoenix_html, "2.10.5"},
      {:phoenix_live_reload, "1.1.3", only: :dev},
      {:gettext, "0.14.1"},
      {:cowboy, "~> 1.0.0"},
      {:create_fun, in_umbrella: true},
      {:ueberauth_identity, "~> 0.2.3"},
      {:guardian, "~> 1.0"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    []
  end
end
