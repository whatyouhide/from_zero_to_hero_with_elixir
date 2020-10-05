defmodule Exercises.BasicsTest do
  use ExUnit.Case
  alias Exercises.Basics

  @tag :skip
  test "average/1" do
    assert Basics.average([100]) == 100
    assert Basics.average([0, 1000]) == 500
    assert Basics.average([1, 1, 1, 1]) == 1
    assert Basics.average([1, 3, 5, 7]) == 4.5

    assert_raise RuntimeError, fn ->
      Basics.average([])
    end
  end

  @tag :skip
  test "ensure_leading_plus/1" do
    assert Basics.ensure_leading_plus("13339944333") == "+13339944333"
    assert Basics.ensure_leading_plus("+13339944333") == "+13339944333"
    assert Basics.ensure_leading_plus("+1 333 994 4333") == "+1 333 994 4333"
  end
end
