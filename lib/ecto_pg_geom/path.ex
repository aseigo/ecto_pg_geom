defmodule EctoPgGeom.Path do
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
