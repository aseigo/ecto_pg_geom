defmodule EctoPgGeom.Line do
  @behaviour Ecto.Type
  def type, do: Postgrex.Line

  # Casting from input into point struct
  def cast({a, b, c}), do: {:ok, %Postgrex.Line{a: a, b: b, c: c}}
  def cast(value = %Postgrex.Line{}), do: {:ok, value}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
