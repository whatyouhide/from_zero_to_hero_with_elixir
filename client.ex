defmodule Chat.Client do
  import IO.ANSI

  def start() do
    {address, port} = get_address_and_port()
    {:ok, socket} = :gen_tcp.connect(address, port, [:binary, packet: 2, active: true])
    nickname = gets("Nickname: ")
    IO.puts("Welcome, #{nickname}!")

    gets_pid = spawn_gets_process(self(), nickname)
    IO.write("#{nickname}: ")

    loop(socket, nickname, gets_pid)
  end

  defp spawn_gets_process(parent, nickname) do
    spawn(fn ->
      message = gets("")
      send(parent, {:gets, message})
    end)
  end

  defp loop(socket, nickname, gets_pid) do
    receive do
      {:gets, message} ->
        payload =
          Jason.encode!(%{"kind" => "broadcast", "nickname" => nickname, "message" => message})

        :ok = :gen_tcp.send(socket, payload)
        IO.write("#{nickname}: ")
        gets_pid = spawn_gets_process(self(), nickname)
        loop(socket, nickname, gets_pid)

      {:tcp, ^socket, data} ->
        %{"kind" => "broadcast", "nickname" => broadcaster_nickname, "message" => message} =
          Jason.decode!(data)

        kill_and_wait(gets_pid)

        IO.puts([cursor_left(1000), clear_line(), "#{broadcaster_nickname}: #{message}"])
        IO.write("#{nickname}: ")

        gets_pid = spawn_gets_process(self(), nickname)

        loop(socket, nickname, gets_pid)

      {:tcp_closed, ^socket} ->
        raise "TCP connection was closed"

      {:tcp_error, ^socket, reason} ->
        raise "TCP connection error: #{:inet.format_error(reason)}"
    end
  end

  defp kill_and_wait(pid) do
    ref = Process.monitor(pid)
    Process.exit(pid, :kill)

    receive do
      {:DOWN, ^ref, _, _, _} -> :ok
    end
  end

  defp get_address_and_port() do
    case gets("Server address as address:port (defaults to localhost:4000): ") do
      "" ->
        {'localhost', 4000}

      other ->
        [address, port] = String.split(other, ":", parts: 2)
        {String.to_charlist(address), String.to_integer(port)}
    end
  end

  defp gets(prompt) do
    prompt |> IO.gets() |> String.trim()
  end
end

Chat.Client.start()
