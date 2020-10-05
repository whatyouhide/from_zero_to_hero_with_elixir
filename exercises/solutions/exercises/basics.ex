defmodule Exercises.Basics do
  @doc """
  Gets the average of a list of numbers.
  """
  def average(list) do
    length = length(list)

    if length == 0 do
      raise "a non-empty list is required"
    else
      Enum.sum(list) / length
    end
  end

  @doc """
  Ensures that the given phone number starts with a `+`.

  You can assume `phone_number` is a string with only number and an optional leading `+`.
  Examples of inputs for this function can be:

    * `+1 333 9944333` - should be left unchanged
    * `13339944333` - should become `+13339944333`

  """
  def ensure_leading_plus(phone_number) do
    if String.start_with?(phone_number, "+") do
      phone_number
    else
      "+" <> phone_number
    end
  end
end
