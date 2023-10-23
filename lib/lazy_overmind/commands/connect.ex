defmodule LazyOvermind.Commands.Connect do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind

  def command(%{socket: socket, status: %{list: list, position: position}} = _project, _model) do
    [process | _] = Enum.at(list, position)

    Command.new(fn ->
      {:start, Overmind.connect(socket, process)}
    end, :callback)
  end
end
