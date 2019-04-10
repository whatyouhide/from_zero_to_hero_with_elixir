defmodule Exercises.Basics do
  @doc """
  Sums the value of all integer values in a list.
  """
  def sum([]) do
    0
  end

  def sum([head | tail]) do
    head + sum(tail)
  end

  @doc """
  Takes the first the `count` elements of a list and returns them.
  """
  def take([head | tail], count) when count > 0 do
    [head | take(tail, count - 1)]
  end

  def take(_list, _count) do
    []
  end

  @doc """
  Returns the minimum element of the list.
  """
  def min([head]) do
    head
  end

  def min([head | tail]) do
    min_tail = min(tail)

    if head < min_tail do
      head
    else
      min_tail
    end
  end
end
