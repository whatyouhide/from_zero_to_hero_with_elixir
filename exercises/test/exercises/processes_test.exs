defmodule Exercises.ProcessesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias Exercises.Processes

  defp receive_once do
    receive do
      result -> result
    end
  end

  @tag :skip
  test "print_messages/0" do
    pid = Processes.print_messages()

    assert capture_io(:stderr, fn ->
      send(pid, "foo")
      # Wait until output has been captured
      Process.sleep(100)
    end) == "foo"

    assert capture_io(:stderr, fn ->
      send(pid, "bar")
      # Wait until output has been captured
      Process.sleep(100)
    end) == "bar"

    assert Process.alive?(pid)
  end

  @tag :skip
  test "sum/0" do
    pid = Processes.sum()
    send(pid, {:sum, self(), 1..2})
    assert receive_once() == 3

    pid = Processes.sum()
    send(pid, {:sum, self(), 1..10})
    assert receive_once() == 55
  end
end
