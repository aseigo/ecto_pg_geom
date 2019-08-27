defmodule EctoPgGeomTest do
  use EctoPgGeom.RepoCase
  doctest EctoPgGeom

  alias EctoPgGeom.TestRepo

  test "Test inserting a box" do
    TestRepo.insert!(%EctoPgGeom.TestSchema{box: [{1, 2}, {3, 4}]})
  end
end
