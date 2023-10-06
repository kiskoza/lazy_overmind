defmodule LazyOvermind.Commands.Start do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind

  def command(%{socket: socket, status: %{position: position, list: list} = _status} = _model) do
    [process | _] = Enum.at(list, position)

    Command.new(fn ->
      {:start, Overmind.start(socket, process)}
    end, :callback)
  end
end
