defmodule EctoPgGeom.Box do
  @behaviour Ecto.Type
  def type, do: Postgrex.Box

  # Casting from input into point struct
  def cast([{_, _} = p1, {_, _} = p2]), do: {:ok, %Postgrex.Box{upper_right: p1, bottom_left: p2}}
  def cast(value = %Postgrex.Box{}), do: {:ok, value}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
