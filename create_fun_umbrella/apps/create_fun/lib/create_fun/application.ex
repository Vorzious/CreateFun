defmodule CreateFun.Application do
  @moduledoc """
  The CreateFun Application Service.

  The create_fun system business domain lives in this application.

  Exposes API to clients such as the `CreateFunWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(CreateFun.Repo, []),
    ], strategy: :one_for_one, name: CreateFun.Supervisor)
  end
end
