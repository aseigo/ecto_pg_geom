defmodule EctoPgGeomTest do
  use EctoPgGeom.RepoCase
  doctest EctoPgGeom
  require Ecto.Query

  alias EctoPgGeom.TestRepo

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

  defp ok_value({:ok, value}), do: value
end
