defmodule LazyOvermind.Commands.StartProcfile do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Overmind
  alias LazyOvermind.Models.Project

  def command(%Project{procfile: procfile, name: name} = _project, _model) do
    socket = "#{name}.sock"

    Command.new(fn ->
      with true <- File.exists?(socket) do
        {:start_procfile, {socket, procfile}}
      else
        _ -> {:start_procfile, Overmind.start_procfile(socket, procfile)}
      end
    end, :callback)
  end
end
