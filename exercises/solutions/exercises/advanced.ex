defmodule Exercises.Advanced do
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
  Return the average value of all numbers in the list.
  """
  def average([head | tail]) do
    do_average(tail, head, _accumulator = 1)
  end

  defp do_average([head | tail], sum, count) do
    do_average(tail, head + sum, _accumulator = count + 1)
  end

  defp do_average([], sum, count) do
    sum / count
  end

  @doc """
  Returns a two element tuple with the odd and even numbers of the list.
  """
  def odds_and_evens(list) do
    do_odds_and_evens(list, [], [])
  end

  defp do_odds_and_evens([head | tail], odds, evens) do
    if rem(head, 2) == 0 do
      do_odds_and_evens(tail, odds, [head | evens])
    else
      do_odds_and_evens(tail, [head | odds], evens)
    end
  end

  defp do_odds_and_evens([], odds, evens) do
    {Enum.reverse(odds), Enum.reverse(evens)}
  end

  @doc """
  Returns the three largest numbers of the list
  """
  def three_largest(list) do
    list
    |> Enum.sort(&>=/2)
    |> Enum.take(3)
    |> Enum.sort(&<=/2)
  end

  @doc """
  Capitalize all words in the given string.

  TIP: Use the functions `String.split/2`, `String.capitalize/1`, and `Enum.join/1`.
  """
  def capitalize_words(string) do
    string
    |> String.split(" ")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
