defmodule EctoPgGeom.Point do
  @moduledoc """
  An Ecto type for [points](https://www.postgresql.org/docs/current/datatype-geometric.html#id-1.5.7.16.5).

  May be used as a field in an `Ecto.Schema` for automatic use of point data stored in the database:

      field :line, EctoPgGeom.Point

  Assigning to a point field can be done either by manually creating a `%Postgrex.Point{}` struct, or by
  passing an `{x, y}` point tuple. `cast/1` and `dump/1` will take care of the translation.

  To create equality checks in queries, use the `EctoPgGeom.geometric_equality/2` macro.
  """

  @behaviour Ecto.Type
  def type, do: Postgrex.Point

  # Casting from input into point struct
  def cast(value = %Postgrex.Point{}), do: {:ok, value}
  def cast({x, y}), do: {:ok, %Postgrex.Point{x: x, y: y}}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
