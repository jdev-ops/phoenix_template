defmodule {{project_name}}.MixProject do
  use Mix.Project

  @app_name :{{name}}
  @version "0.1.0"

  def project do
    [
      app: @app_name,
      version: @version,
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Releases
      releases: releases(),

      # Dialyzer
      dialyzer: dialyzer(),

    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: { {{project_name}}.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon, :jason, :logger_json]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.6"},
      {:phoenix_ecto, "~> 4.2"},
      {:ecto_sql, "~> 3.5"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.14"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},

      {:phoenix_live_dashboard, "~> 0.3"},
      {:ecto_psql_extras, "~> 0.4.0"},
#      {:ecto_psql_extras, "== 0.3.0"},

      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 0.5"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.4"},

      {:logger_json, "~> 4.1"},

      {:phoenix_live_view, "~> 0.14.7"},
      {:floki, ">= 0.27.0", only: :test},

      # Code Analysis
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test]},

    ]
  end


  defp release_version(nil), do: @version
  defp release_version(suffix), do: @version <> "-" <> suffix

  defp copy_extra_files(rel) do
    #    File.copy!(
    #      "config/prod.exs",
    #      "#{rel.path}/releases/#{release_version(System.get_env("RELEASE_TAR_NAME_SUFFIX"))}/releases.exs"
    #    )
    rel
  end

  defp releases() do
    [
      {
        @app_name,
        [
          version: release_version(System.get_env("RELEASE_TAR_NAME_SUFFIX")),
          steps: [:assemble, &copy_extra_files/1, :tar],
          path: "#{System.get_env("MIX_RELEASE_PATH", "_build")}/#{
            #          path: "#{System.get_env("MIX_RELEASE_PATH", "cli/devOps/ansible/roles/elixir/files/app/build")}/#{
            to_string(@app_name)
          }", # Defaults to "_build/MIX_ENV/rel/RELEASE_NAME"
          include_executables_for: [:unix],
          applications: [
            runtime_tools: :permanent,
            logger: :permanent,
          ],
        ]
      },
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:mix, :eex,],
      ignore_warnings: "dialyzer.ignore-warnings",
      flags: [
        :unmatched_returns,
        :error_handling,
        :race_conditions,
        :no_opaque,
        :unknown,
        :no_return
      ]
    ]
  end

end
