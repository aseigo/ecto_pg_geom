defmodule EctoPgGeom.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_pg_geom,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      config_path: config_files(Mix.env()),
      package: package(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: mod(Mix.env())
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 3.1.4"},
      {:ecto_sql, "~> 3.1.6", only: :test},
      {:ex_doc, "~> 0.21.1", only: :dev}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp config_files(:test), do: "config/test.exs"
  defp config_files(_), do: "config/config.exs"

  defp mod(:test), do: {EctoPgGeomTest.App, []}
  defp mod(_), do: []

  defp aliases do
    [
     test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Aaron Seigo"],
      description: "Ecto support for Postgres geometry types",
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/aseigo/ecto_pg_geom"}
    ]
  end
end
