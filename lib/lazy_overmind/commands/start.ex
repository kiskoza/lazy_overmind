defmodule LazyOvermind.Commands.Start do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind
    alias LazyOvermind.Models.{ProjectStatus, Project}

  def command(%Project{socket: socket, status: %ProjectStatus{list: list, position: position}} = _project, _model) do
    [process | _] = Enum.at(list, position)

    Command.new(fn ->
      {:start, Overmind.start(socket, process)}
    end, :callback)
  end
end
