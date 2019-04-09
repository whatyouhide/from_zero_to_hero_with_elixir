defmodule Exercises.Processes do
  @doc """
  Print all messages sent to the process.

  Print the messages using `IO.write(:stderr, message)`.
  """
  def print_messages() do
    spawn(&print_messages_recursive/0)
  end

  defp print_messages_recursive() do
    receive do
      _message ->
        raise "not implemented yet"
    end
  end

  @doc """
  Spawn a process that replies with the sum of all numbers in the sent list.

  The process should expect a message of the form `{:sum, pid, list}`. Sum the numbers in
  `list` and send the result to `pid`.
  """
  def sum() do
    raise "not implemented yet"
  end
end
