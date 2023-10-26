defmodule LazyOvermind.Commands.Connect do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind
  alias LazyOvermind.Models.Project

  def command(%Project{socket: socket, processes: processes, processes_cursor: position} = _project, _model) do
    [process | _] = Enum.at(processes, position)

    Command.new(fn ->
      {:start, Overmind.connect(socket, process)}
    end, :callback)
  end
end
