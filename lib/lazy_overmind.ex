defmodule LazyOvermind do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Ratatouille.Runtime.Supervisor,
       runtime: [app: LazyOvermind.App, shutdown: {:application, :lazy_overmind}]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: LazyOvermind.Supervisor)
  end

  def stop(_) do
    System.halt(0)
  end
end
