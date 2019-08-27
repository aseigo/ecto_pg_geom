defmodule EctoPgGeomTest.App do
  use Application
  alias EctoPgGeom.TestRepo

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      EctoPgGeom.TestRepo
    ]

    opts = [strategy: :one_for_one, name: EctoPgGeomTest.App]
    Supervisor.start_link(children, opts)
  end
end
