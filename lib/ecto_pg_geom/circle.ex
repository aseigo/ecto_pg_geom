defmodule EctoPgGeom.Circle do
  @moduledoc """
  An Ecto type for [circles](https://www.postgresql.org/docs/current/datatype-geometric.html#DATATYPE-CIRCLE).

  May be used as a field in an `Ecto.Schema` for automatic use of box data stored in the database:

      field :circle, EctoPgGeom.Circle

  Assigning to a box field can be done either by manually creating a `%Postgrex.Circle{}` struct, or by
  passing data in the shape of `{{x, y}, radius}`. `cast/1` and `dump/1` will take care of the translation.
  """

  @behaviour Ecto.Type
  def type, do: Postgrex.Circle

  # Casting from input into point struct
  def cast(value = %Postgrex.Circle{}), do: {:ok, value}
  def cast({{x, y}, r}), do: {:ok, %Postgrex.Circle{center: %Postgrex.Point{x: x, y: y}, radius: r}}
  def cast({r, {x, y}}), do: {:ok, %Postgrex.Circle{center: %Postgrex.Point{x: x, y: y}, radius: r}}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  # dumping data to the database
  def dump(value), do: cast(value)
end
