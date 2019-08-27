defmodule EctoPgGeom.TestRepo.Migrations.AddTestingTable do
  use Ecto.Migration

  def change do
    create table("test_all_geometry_types") do
      add :box, :box
      add :circle, :circle
      add :line, :line
      add :line_segment, :lseg
      add :path, :path
      add :point, :point
      add :polygon, :polygon
    end
  end
end
