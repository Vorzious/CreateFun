defmodule CreateFunCms.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start your own worker by calling: CreateFunCms.Worker.start_link(arg1, arg2, arg3)
      # worker(CreateFunCms.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CreateFunCms.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
