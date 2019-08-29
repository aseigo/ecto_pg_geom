defmodule EctoPgGeom.Box do
  @moduledoc """
  An Ecto type for [boxes](https://www.postgresql.org/docs/current/datatype-geometric.html#id-1.5.7.16.8).

  May be used as a field in an `Ecto.Schema` for automatic use of box data stored in the database:

      field :box, EctoPgGeom.Box

  Assigning to a box field can be done either by manually creating a `%Postgrex.Box{}` struct, or by
  passing data in the shape of `[{x1, y1}, {x2, y2}]`. `cast/1` and `dump/1` will take care of the translation.
  """

  @behaviour Ecto.Type
  def type, do: Postgrex.Box

  # Casting from input into point struct
  def cast(%Postgrex.Box{} = value), do: {:ok, value}
  def cast([{_, _} = p1, {_, _} = p2]) do
    {:ok, upper_right} =  EctoPgGeom.Point.cast(p1)
    {:ok, bottom_left} =  EctoPgGeom.Point.cast(p2)
    {:ok, %Postgrex.Box{upper_right: upper_right, bottom_left: bottom_left}}
  end
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
