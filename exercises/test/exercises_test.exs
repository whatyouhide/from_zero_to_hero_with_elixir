defmodule ExercisesTest do
  use ExUnit.Case
  doctest Exercises

  test "greets the world" do
    assert Exercises.hello() == :world
  end
end
