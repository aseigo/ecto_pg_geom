defmodule EctoPgGeom.Path do
  @moduledoc """
  An Ecto type for [paths](https://www.postgresql.org/docs/current/datatype-geometric.html#id-1.5.7.16.9).

  May be used as a field in an `Ecto.Schema` for automatic use of box data stored in the database:

      field :line, EctoPgGeom.Path

  Assigning to a box field can be done either by manually creating a `%Postgrex.Path{}` struct, or by
  passing a list of points for a closed path or a tuple of points for an open path.
  `cast/1` and `dump/1` will take care of the translation.
  """

  @behaviour Ecto.Type
  def type, do: Postgrex.Path

  # Casting from input into point struct
  def cast(value = %Postgrex.Path{}), do: {:ok, value}
  def cast(points) when is_list(points) do
    points =
      Enum.reduce(points, [], &EctoPgGeom.Polygon.to_point_structs/2)
      |> Enum.reverse()
    {:ok, %Postgrex.Path{open: false, points: points}}
  end
  def cast(points) when is_tuple(points) do
    points = open_points_to_struct(points, tuple_size(points), [])
    {:ok, %Postgrex.Path{open: true, points: points}}
  end
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)

  defp open_points_to_struct(_points, 0, acc), do: Enum.reverse(acc)
  defp open_points_to_struct(points, count, acc), do: open_points_to_struct(points, count - 1, EctoPgGeom.Polygon.to_point_structs(elem(points, count - 1), acc))
end
