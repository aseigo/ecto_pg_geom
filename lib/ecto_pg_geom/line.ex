defmodule EctoPgGeom.Line do
  @moduledoc """
  An Ecto type for [lines](https://www.postgresql.org/docs/current/datatype-geometric.html#DATATYPE-LINE).

  May be used as a field in an `Ecto.Schema` for automatic use of box data stored in the database:

      field :line, EctoPgGeom.Line

  Assigning to a box field can be done either by manually creating a `%Postgrex.Line{}` struct, or by
  passing a `{A, B, C}` line definition, where `Ax + By + C = 0`. `cast/1` and `dump/1` will take care of the translation.
  """

  @behaviour Ecto.Type
  def type, do: Postgrex.Line

  # Casting from input into point struct
  def cast(value = %Postgrex.Line{}), do: {:ok, value}
  def cast({a, b, c}), do: {:ok, %Postgrex.Line{a: a, b: b, c: c}}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
