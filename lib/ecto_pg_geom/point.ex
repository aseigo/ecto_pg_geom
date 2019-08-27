defmodule EctoPgGeom.Point do
  @behaviour Ecto.Type
  def type, do: Postgrex.Point

  # Casting from input into point struct
  def cast({x, y}), do: {:ok, %Postgrex.Point{x: x, y: y}}
  def cast(value = %Postgrex.Point{}), do: {:ok, value}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
