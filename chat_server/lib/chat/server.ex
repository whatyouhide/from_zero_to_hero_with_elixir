defmodule Chat.Server do
  use GenServer

  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  ## Callbacks

  @impl true
  def init(opts) do
    port = Keyword.fetch!(opts, :port)

    case :gen_tcp.listen(port, [:binary, packet: 2]) do
      {:ok, listen_socket} ->
        Logger.debug("Listening on port #{port}")
        send(self(), :accept)
        {:ok, listen_socket}

      {:error, reason} ->
        Logger.error("Couldn't start listen socket: #{:inet.format_error(reason)}")
        {:stop, reason}
    end
  end

  @impl true
  def handle_info(:accept, listen_socket) do
    Logger.debug("Accepting connections")

    case :gen_tcp.accept(listen_socket) do
      {:ok, socket} ->
        Logger.debug("Accepted new socket")

        {:ok, pid} =
          DynamicSupervisor.start_child(
            Chat.Server.ConnectionSupervisor,
            {Chat.Server.Connection, socket: socket}
          )

        :ok = :gen_tcp.controlling_process(socket, pid)
        send(self(), :accept)
        {:noreply, listen_socket}

      {:error, reason} ->
        Logger.error("Couldn't accept new connections: #{:inet.format_error(reason)}")
        {:noreply, listen_socket, {:continue, :accept}}
    end
  end
end
