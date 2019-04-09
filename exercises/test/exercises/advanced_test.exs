defmodule Exercises.AdvancedTest do
  use ExUnit.Case
  alias Exercises.Advanced

  @tag :skip
  test "average/1" do
    assert Advanced.average([5]) == 5
    assert Advanced.average([5, 5]) == 5
    assert Advanced.average([5, 6, 7]) == 6
  end

  @tag :skip
  test "odds_and_evens/1" do
    assert Advanced.odds_and_evens([]) == {[], []}
    assert Advanced.odds_and_evens([1, 3, 5]) == {[1, 3, 5], []}
    assert Advanced.odds_and_evens([2, 4, 6]) == {[], [2, 4, 6]}
    assert Advanced.odds_and_evens([6, 5, 4, 3, 2, 1]) == {[5, 3, 1], [6, 4, 2]}
  end

  @tag :skip
  test "three_largest/1" do
    assert Advanced.three_largest([]) == []
    assert Advanced.three_largest([4, 9, 6, 3, 1]) == [4, 6, 9]
    assert Advanced.three_largest([-7, 3, 0, 9, 3, 2]) == [3, 3, 9]
    assert Advanced.three_largest([5, -2]) == [-2, 5]
  end

  @tag :skip
  test "capitalize_all/1" do
    assert Advanced.capitalize_all("") == ""
    assert Advanced.capitalize_all("foo bar") == "Foo Bar"
    assert Advanced.capitalize_all("FOO BAR") == "Foo Bar"
    assert Advanced.capitalize_all("elixirconf EU  2019") == "Elixirconf Eu  2019"
  end
end
