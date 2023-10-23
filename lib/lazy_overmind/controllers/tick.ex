defmodule LazyOvermind.Controllers.Tick do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Commands.Status

  def update(%{projects: %{list: list} = _projects } = model, _payload) do
    commands = list
    |> Enum.filter(fn %{visibility: visibility} = _project -> visibility != :hidden end)
    |> Enum.map(fn project -> Status.command(project, model) end)

    case commands do
      [] -> model
      _ -> {model, Command.batch(commands) }
    end
  end
end
