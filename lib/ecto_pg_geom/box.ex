defmodule EctoPgGeom.Box do
  @behaviour Ecto.Type
  def type, do: Postgrex.Box

  # Casting from input into point struct
  def cast([{_, _} = p1, {_, _} = p2]) do
    {:ok, upper_right} =  EctoPgGeom.Point.cast(p1)
    {:ok, bottom_left} =  EctoPgGeom.Point.cast(p2)
    {:ok, %Postgrex.Box{upper_right: upper_right, bottom_left: bottom_left}}
  end
  def cast(%Postgrex.Box{} = value), do: {:ok, value}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
