defmodule Chat.Client do
  use GenServer

  require Logger

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

    {:ok, _} = GenServer.start_link(__MODULE__, {address, port}, name: :client)

    nickname = String.trim(IO.gets("Nickname: "))
    gets_loop(nickname)
  end

  def init({address, port}) do
    {:ok, socket} = :gen_tcp.connect(address, port, [:binary, packet: 2, active: true])
    Logger.info("Connected to #{address}:#{port}")
    {:ok, socket}
  end

  def handle_info({:send_to_server, message}, socket) do
    payload = Jason.encode!(message)
    :ok = :gen_tcp.send(socket, payload)
    {:noreply, socket}
  end

  def handle_info({:tcp, socket, data}, socket) do
    case Jason.decode(data) do
      {:ok, %{"kind" => "broadcast", "nickname" => broadcaster_nickname, "message" => message}} ->
        IO.puts("#{broadcaster_nickname}: #{message}")

      {:error, reason} ->
        IO.puts("ERROR: error decoding JSON: #{inspect(reason)}")
    end

    {:noreply, socket}
  end

  def handle_info({:tcp_closed, socket}, socket) do
    raise "TCP connection was closed"
  end

  def handle_info({:tcp_error, socket, reason}, socket) do
    raise "TCP connection error: #{:inet.format_error(reason)}"
  end
end

Chat.Client.start()
