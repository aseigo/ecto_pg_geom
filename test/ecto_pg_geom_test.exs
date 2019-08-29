defmodule EctoPgGeomTest do
  use EctoPgGeom.RepoCase
  doctest EctoPgGeom
  require Ecto.Query

  alias EctoPgGeom.TestRepo
  import EctoPgGeom, only: [geometric_equality: 2]

  test "Test insert, query, and delete of Box" do
    coords = [{3, 4}, {1, 2}]
    {:ok, box_struct} = EctoPgGeom.Box.cast(coords)
    row = %EctoPgGeom.TestSchema{box: coords}
    other_box = %EctoPgGeom.TestSchema{box: [{2, 5}, {8, 12}]}

    # insert
    {success, insert_data} = TestRepo.insert(row)
    assert(success == :ok)
    assert(insert_data.box == coords)

    # select
    select_data = TestRepo.all(EctoPgGeom.TestSchema) |> Enum.at(0)
    assert(select_data.box == box_struct)

    # deletion of a specific box
    TestRepo.insert(other_box)
    query = from t in EctoPgGeom.TestSchema, where: t.box == ^box_struct
    assert({1, nil} == TestRepo.delete_all(query))
  end

  test "Test insert, query, and delete of a circle" do
    circle_1 = {{1, 2}, 3}
    circle_2 = {3, {1, 2}}
    circle_3 = {{10, 20}, 30}

    # test cast of different forms
    {:ok, circle_struct} = EctoPgGeom.Circle.cast(circle_1)
    assert(circle_struct == ok_value(EctoPgGeom.Circle.cast(circle_2)))
    refute(circle_struct == ok_value(EctoPgGeom.Circle.cast(circle_3)))

    row = %EctoPgGeom.TestSchema{circle: circle_1}
    other_row = %EctoPgGeom.TestSchema{circle: circle_3}

    # insert
    {success, insert_data} = TestRepo.insert(row)
    assert(success == :ok)
    assert(insert_data.circle == circle_1)

    # select
    select_data = TestRepo.all(EctoPgGeom.TestSchema) |> Enum.at(0)
    assert(select_data.circle == circle_struct)

    # deletion of a specific box
    TestRepo.insert(other_row)
    query = from t in EctoPgGeom.TestSchema, where: t.circle == ^circle_struct
    assert({1, nil} == TestRepo.delete_all(query))
  end

  test "Test insert, query, and delete of a line" do
    line_1 = {1, 2, 3}
    line_2 = {3, 1, 2}

    # test cast of different forms
    {:ok, line_struct} = EctoPgGeom.Line.cast(line_1)
    refute(line_struct == ok_value(EctoPgGeom.Line.cast(line_2)))

    row = %EctoPgGeom.TestSchema{line: line_1}
    other_row = %EctoPgGeom.TestSchema{line: line_2}

    # insert
    {success, insert_data} = TestRepo.insert(row)
    assert(success == :ok)
    assert(insert_data.line == line_1)

    # select
    select_data = TestRepo.all(EctoPgGeom.TestSchema) |> Enum.at(0)
    assert(select_data.line == line_struct)

    # deletion of a specific box
    TestRepo.insert(other_row)
    query = from t in EctoPgGeom.TestSchema, where: t.line == ^line_struct
    assert({1, nil} == TestRepo.delete_all(query))
  end

  test "Test insert, query, and delete of a line segment" do
    line_seg_1 = [{1, 2}, {3, 4}]
    line_seg_2 = [{42, 53}, {84, 95}]

    # test cast of different forms
    {:ok, line_seg_struct} = EctoPgGeom.LineSegment.cast(line_seg_1)
    refute(line_seg_struct == ok_value(EctoPgGeom.LineSegment.cast(line_seg_2)))

    row = %EctoPgGeom.TestSchema{line_segment: line_seg_1}
    other_row = %EctoPgGeom.TestSchema{line_segment: line_seg_2}

    # insert
    {success, insert_data} = TestRepo.insert(row)
    assert(success == :ok)
    assert(insert_data.line_segment == line_seg_1)

    # select
    select_data = TestRepo.all(EctoPgGeom.TestSchema) |> Enum.at(0)
    assert(select_data.line_segment == line_seg_struct)

    # deletion of a specific box
    TestRepo.insert(other_row)
    query = from t in EctoPgGeom.TestSchema, where: t.line_segment == ^line_seg_struct
    assert({1, nil} == TestRepo.delete_all(query))
  end

  test "Test insert, query, and delete of a path" do
    path_1 = [{1, 2}, {2, 3}]
    path_2 = [%Postgrex.Point{x: 1, y: 2}, {2, 3}]
    path_3 = [{1, 2}, {2, 3}, {3, 4}]
    path_4 = {{1, 2}, {2, 3}, {3, 4}}

    # test cast of different forms
    {:ok, path_struct} = EctoPgGeom.Path.cast(path_1)
    assert(path_struct == ok_value(EctoPgGeom.Path.cast(path_2)))
    refute(path_struct == ok_value(EctoPgGeom.Path.cast(path_3)))
    refute(EctoPgGeom.Path.cast(path_3) == EctoPgGeom.Path.cast(path_4))
    assert(!path_struct.open)
    assert(ok_value(EctoPgGeom.Path.cast(path_4)).open)

    row = %EctoPgGeom.TestSchema{path: path_1}
    other_row = %EctoPgGeom.TestSchema{path: path_3}

    # insert
    {success, insert_data} = TestRepo.insert(row)
    assert(success == :ok)
    assert(insert_data.path == path_1)

    # select
    select_data = TestRepo.all(EctoPgGeom.TestSchema) |> Enum.at(0)
    assert(select_data.path == path_struct)

    # deletion of a specific box
    TestRepo.insert(other_row)
    query = from t in EctoPgGeom.TestSchema, where: t.path == ^path_struct
    assert({1, nil} == TestRepo.delete_all(query))
  end

  test "Test insert, query, and delete of a point" do
    point_1 = {1, 2}
    point_2 = {3, 1}

    # test cast of different forms
    {:ok, point_struct} = EctoPgGeom.Point.cast(point_1)
    refute(point_struct == ok_value(EctoPgGeom.Point.cast(point_2)))

    row = %EctoPgGeom.TestSchema{point: point_1}
    other_row = %EctoPgGeom.TestSchema{point: point_2}

    # insert
    {success, insert_data} = TestRepo.insert(row)
    assert(success == :ok)
    assert(insert_data.point == point_1)

    # select
    select_data = TestRepo.all(EctoPgGeom.TestSchema) |> Enum.at(0)
    assert(select_data.point == point_struct)

    # deletion of a specific box
    TestRepo.insert(other_row)
    #query = from t in EctoPgGeom.TestSchema, where: fragment("? ~= ?", t.point, ^point_struct)
    query = from t in EctoPgGeom.TestSchema, where: geometric_equality(t.point, point_struct)
    assert({1, nil} == TestRepo.delete_all(query))
  end

  test "Test insert, query, and delete of a polygon" do
    polygon_1 = [{1, 2}, {2, 3}]
    polygon_2 = [%Postgrex.Point{x: 1, y: 2}, {2, 3}]
    polygon_3 = [{1, 2}, {2, 3}, {3, 4}]

    # test cast of different forms
    {:ok, polygon_struct} = EctoPgGeom.Polygon.cast(polygon_1)
    assert(polygon_struct == ok_value(EctoPgGeom.Polygon.cast(polygon_2)))
    refute(polygon_struct == ok_value(EctoPgGeom.Polygon.cast(polygon_3)))

    row = %EctoPgGeom.TestSchema{polygon: polygon_1}
    other_row = %EctoPgGeom.TestSchema{polygon: polygon_3}

    # insert
    {success, insert_data} = TestRepo.insert(row)
    assert(success == :ok)
    assert(insert_data.polygon == polygon_1)

    # select
    select_data = TestRepo.all(EctoPgGeom.TestSchema) |> Enum.at(0)
    assert(select_data.polygon == polygon_struct)

    # deletion of a specific box
    TestRepo.insert(other_row)
    query = from t in EctoPgGeom.TestSchema, where: geometric_equality(t.polygon, polygon_struct)
    assert({1, nil} == TestRepo.delete_all(query))
  end

  defp ok_value({:ok, value}), do: value
end
