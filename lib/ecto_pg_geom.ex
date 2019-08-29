defmodule EctoPgGeom do
  @moduledoc """
  A collection of modules allowing [Postgres Geometry types](https://www.postgresql.org/docs/9.4/datatype-geometric.html)
  to be used in Ecto, via the Postgrex library.
  """

  @doc """
  A macro that generates an Ecto fragment which compares the equality of two
  geometries. Required for testing equality of geometric types such as points
  and polygons which do not have a functional `=` operator.

  To use `import EctoPgGeom, only: [geometric_equality: 2]` and then you may
  use in e.g. Ecto query where clauses: `geometric_equality(t.point, point)`
  """
  defmacro geometric_equality(p1, p2) do
    quote do: fragment("? ~= ?", unquote(p1), ^unquote(p2))
  end

end
