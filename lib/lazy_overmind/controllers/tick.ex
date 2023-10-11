defmodule LazyOvermind.Controllers.Tick do
  alias Ratatouille.Runtime.Command

  alias LazyOvermind.Commands.Status

  def update(%{projects: %{list: list} = _projects } = model, _payload) do
    commands = list
    |> Enum.filter(fn %{active: active} = _project -> active end)
    |> Enum.map(fn project -> Status.command(project, model) end)
    |> Command.batch()

    {model, commands}
  end
end
