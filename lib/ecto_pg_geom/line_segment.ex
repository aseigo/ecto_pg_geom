defmodule EctoPgGeom.LineSegment do
  @moduledoc """
  An Ecto type for [line segments](https://www.postgresql.org/docs/current/datatype-geometric.html#DATATYPE-LSEG).

  May be used as a field in an `Ecto.Schema` for automatic use of line segment data stored in the database:

      field :line, EctoPgGeom.LineSegment

  Assigning to a line segment field can be done either by manually creating a `%Postgrex.LineSegment{}` struct, or by
  passing a pair of points in a list: `[{x1, y1, {x2, y2}]`. `cast/1` and `dump/1` will take care of the translation.
  """

  @behaviour Ecto.Type
  def type, do: Postgrex.LineSegment

  # Casting from input into point struct
  def cast(value = %Postgrex.LineSegment{}), do: {:ok, value}

  def cast([{_, _} = point1, {_, _} = point2]) do
    {:ok, point1} = EctoPgGeom.Point.cast(point1)
    {:ok, point2} = EctoPgGeom.Point.cast(point2)
    {:ok, %Postgrex.LineSegment{point1: point1, point2: point2}}
  end

  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
