defmodule Chat.Client do
  def gets_loop(nickname) do
    message = String.trim(IO.gets("#{nickname}: "))
    message = %{"kind" => "broadcast", "message" => message, "nickname" => nickname}
    send(Process.whereis(:client), {:send_to_server, message})
    gets_loop(nickname)
  end

  def start() do
    {address, port} =
      case String.trim(IO.gets("Server address as address:port (defaults to localhost:4000): ")) do
        "" ->
          {'localhost', 4000}

        other ->
          [address, port] = String.split(other, ":", parts: 2)
          {String.to_charlist(address), String.to_integer(port)}
      end

    parent = self()
    loop_pid = spawn_link(fn -> process_loop(parent, address, port) end)

    receive do
      {:ready, ^loop_pid} -> :ok
    end

    Process.register(loop_pid, :client)

    nickname = String.trim(IO.gets("Nickname: "))
    gets_loop(nickname)
  end

  defp process_loop(parent, address, port) do
    {:ok, socket} = :gen_tcp.connect(address, port, [:binary, packet: 2, active: true])
    send(parent, {:ready, self()})
    process_loop(socket)
  end

  defp process_loop(socket) do
    receive do
      {:send_to_server, message} ->
        payload = Jason.encode!(message)
        :ok = :gen_tcp.send(socket, payload)
        process_loop(socket)

      {:tcp, ^socket, data} ->
        case Jason.decode(data) do
          {:ok,
           %{"kind" => "broadcast", "nickname" => broadcaster_nickname, "message" => message}} ->
            IO.puts("#{broadcaster_nickname}: #{message}")

          {:error, reason} ->
            IO.puts("ERROR: error decoding JSON: #{inspect(reason)}")
        end

        process_loop(socket)

      {:tcp_closed, ^socket} ->
        raise "TCP connection was closed"

      {:tcp_error, ^socket, reason} ->
        raise "TCP connection error: #{:inet.format_error(reason)}"
    end
  end
end

Chat.Client.start()
