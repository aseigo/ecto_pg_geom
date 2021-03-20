defmodule EctoPgGeom.Polygon do
  @moduledoc """
  An Ecto type for [polygon](https://www.postgresql.org/docs/current/datatype-geometric.html#DATATYPE-POLYGON).

  May be used as a field in an `Ecto.Schema` for automatic use of polygon data stored in the database:

      field :line, EctoPgGeom.Polygon

  Assigning to a polygon field can be done either by manually creating a `%Postgrex.Polygon{}` struct, or by
  passing a list of points, such as `[{1, 2}, {30, 40}, {14, 15}]`. `cast/1` and `dump/1` will take care of the translation.

  To create equality checks in queries, use the `EctoPgGeom.geometric_equality/2` macro.
  """

  @behaviour Ecto.Type
  def type, do: Postgrex.Polygon

  # Casting from input into point struct
  def cast(value = %Postgrex.Polygon{}), do: {:ok, value}

  def cast(points) when is_list(points) do
    vertices =
      Enum.reduce(points, [], &EctoPgGeom.Point.convert_to_struct/2)
      |> Enum.reverse()

    {:ok, %Postgrex.Polygon{vertices: vertices}}
  end

  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)

  def equal?(left, right), do: left.points == right.points
  def embed_as(_format), do: :self
end
