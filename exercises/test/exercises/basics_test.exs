defmodule Exercises.BasicsTest do
  use ExUnit.Case
  alias Exercises.Basics

  @tag :skip
  test "sum/1" do
    assert Basics.sum([]) == 0
    assert Basics.sum([5]) == 5
    assert Basics.sum([5, 6, 7]) == 18
  end

  @tag :skip
  test "take/2" do
    assert Basics.take([], 0) == []
    assert Basics.take([], 2) == []
    assert Basics.take([1, 2, 3], 0) == []
    assert Basics.take([1, 2, 3], 2) == [1, 2]
    assert Basics.take([1, 2, 3], 3) == [1, 2, 3]
    assert Basics.take([1, 2, 3], 4) == [1, 2, 3]
  end

  @tag :skip
  test "min/1" do
    assert Basics.min([5]) == 5
    assert Basics.min([1, 2, 3]) == 1
    assert Basics.min([3, 2, 1]) == 1
    assert Basics.min([2, 1, 3]) == 1
    assert Basics.min([1, -1, 0]) == -1
  end
end
