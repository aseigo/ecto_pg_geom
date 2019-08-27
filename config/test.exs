use Mix.Config

config :ecto_pg_geom,
  ecto_repos: [EctoPgGeom.TestRepo]

config :ecto_pg_geom, EctoPgGeom.TestRepo,
  username: "postgres",
  password: "postgres",
  database: "ecto_pg_geom_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

