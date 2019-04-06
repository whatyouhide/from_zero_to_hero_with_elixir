defmodule ChatTest do
  use ExUnit.Case
  doctest Chat

  test "greets the world" do
    assert Chat.hello() == :world
  end
end
