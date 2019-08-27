defmodule EctoPgGeom.Polygon do
  @behaviour Ecto.Type
  def type, do: Postgrex.Polygon

  # Casting from input into point struct
  def cast(value = %Postgrex.Polygon{}), do: {:ok, value}
  def cast(points) when is_list(points) do
    vertices =
      Enum.reduce(points, [], &to_point_structs/2)
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

  def to_point_structs(%Postgrex.Point{} = point, acc), do: [point | acc]
  def to_point_structs({x, y}, acc), do: [%Postgrex.Point{x: x, y: y}| acc]
end
