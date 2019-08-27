defmodule EctoPgGeom.Circle do
  @behaviour Ecto.Type
  def type, do: Postgrex.Circle

  # Casting from input into point struct
  def cast({{x, y}, r}), do: {:ok, %Postgrex.Circle{center: %Postgrex.Point{x: x, y: y}, radius: r}}
  def cast({r, {x, y}}), do: {:ok, %Postgrex.Circle{center: %Postgrex.Point{x: x, y: y}, radius: r}}
  def cast(value = %Postgrex.Circle{}), do: {:ok, value}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
