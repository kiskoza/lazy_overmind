defmodule LazyOvermind.Commands.StopProcfile do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind
  alias LazyOvermind.Models.Project

  def command(%Project{socket: socket, procfile: procfile} = _project, _model) do
    Command.new(fn ->
      {:stop_procfile, Overmind.stop_procfile(socket, procfile)}
    end, :callback)
  end
end
