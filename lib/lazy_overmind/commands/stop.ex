defmodule LazyOvermind.Commands.Stop do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind

  def command(%{socket: socket, status: %{position: position, list: list} = _status} = _model) do
    [process | _] = Enum.at(list, position)

    Command.new(fn ->
      {:stop, Overmind.stop(socket, process)}
    end, :callback)
  end
end