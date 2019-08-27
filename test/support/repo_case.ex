defmodule EctoPgGeom.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias EctoPgGeom.TestRepo

      import Ecto
      import Ecto.Query
      import EctoPgGeom.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EctoPgGeom.TestRepo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(EctoPgGeom.TestRepo, {:shared, self()})
    end

    :ok
  end
end
