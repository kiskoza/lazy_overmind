defmodule LazyOvermind.Commands.Status do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind

  def command(%{socket: socket} = _model) do
    Command.new(fn ->
      {:status, Overmind.status(socket)}
    end, :callback)
  end
end
