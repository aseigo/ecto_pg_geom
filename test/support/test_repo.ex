defmodule EctoPgGeom.TestRepo do
  use Ecto.Repo,
    otp_app: :ecto_pg_geom,
    adapter: Ecto.Adapters.Postgres
end

