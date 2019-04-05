defmodule Chat.Server.Data do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> MapSet.new() end, name: __MODULE__)
  end

  def get_all_connections() do
    Agent.get(__MODULE__, & &1)
  end

  def register() do
    pid = self()
    Agent.update(__MODULE__, &MapSet.put(&1, pid))
  end

  def unregister() do
    pid = self()
    Agent.update(__MODULE__, &MapSet.delete(&1, pid))
  end
end
