defmodule EctoPgGeom.LineSegment do
  @behaviour Ecto.Type
  def type, do: Postgrex.LineSegment

  # Casting from input into point struct
  def cast([{_, _} = point1, {_, _} = point2]) do
    {:ok, point1} = EctoPgGeom.Point.cast(point1)
    {:ok, point2} = EctoPgGeom.Point.cast(point2)
    {:ok, %Postgrex.LineSegment{point1: point1, point2: point2}}
  end
  def cast(value = %Postgrex.LineSegment{}), do: {:ok, value}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
