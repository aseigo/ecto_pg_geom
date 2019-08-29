defmodule EctoPgGeom.Point do
  @behaviour Ecto.Type
  def type, do: Postgrex.Point

  defmacro point_equality(p1, p2) do
    quote do: fragment("? ~= ?", unquote(p1), ^unquote(p2))
  end

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
