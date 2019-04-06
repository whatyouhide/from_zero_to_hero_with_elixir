defmodule Chat.Application do
  use Application

  def start(_type, _info) do
    children = [
      Chat.Server.Data,
      {Chat.Server, port: 4000},
      {DynamicSupervisor, strategy: :one_for_one, name: Chat.Server.ConnectionSupervisor}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
