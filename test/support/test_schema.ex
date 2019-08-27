defmodule EctoPgGeom.TestSchema do
  use Ecto.Schema

  schema "test_all_geometry_types" do
    field :box, EctoPgGeom.Box
    field :circle, EctoPgGeom.Circle
    field :line, EctoPgGeom.Line
    field :line_segment, EctoPgGeom.LineSegment
    field :path, EctoPgGeom.Path
    field :point, EctoPgGeom.Point
    field :polygon, EctoPgGeom.Polygon
  end
end

