defmodule EctoPgGeom.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_pg_geom,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      config_path: config_files(Mix.env()),
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
      {:ecto_sql, "~> 3.1.6", only: :test}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp config_files(:test), do: "config/test.exs"
  defp config_files(_), do: "config/config.exs"

  defp mod(:test), do: {EctoPgGeomTest.App, []}
  defp mod(_), do: nil

  defp aliases do
    [
     test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
