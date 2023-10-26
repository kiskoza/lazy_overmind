defmodule LazyOvermind.Commands.Status do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind
  alias LazyOvermind.Models.Project

  def command(%Project{socket: socket} = _project, _model) do
    Command.new(fn ->
      {:status, Overmind.status(socket)}
    end, :callback)
  end
end
