defmodule LazyOvermind.Controllers.Tick do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Commands.Status
  alias LazyOvermind.Models.Project

  def update(%{projects: %{list: list} = _projects } = model, _payload) do
    commands = list
    |> Enum.filter(fn %Project{visibility: visibility} = _project -> visibility != :hidden end)
    |> Enum.filter(fn %Project{status: status} = _project -> status == :running end)
    |> Enum.map(fn project -> Status.command(project, model) end)

    case commands do
      [] -> model
      _ -> {model, Command.batch(commands) }
    end
  end
end
