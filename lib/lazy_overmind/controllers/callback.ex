defmodule LazyOvermind.Controllers.Callback do
  alias LazyOvermind.Utils.Panel

  alias LazyOvermind.Models.Project

  def update(%{projects: %{list: project_list} = projects, window: window_size} = model, {:status, {socket, processes}} = _payload) do
    %{model |
      projects: %{ projects |
                   list: project_list
                   |> Enum.map(fn project ->
                     case project do
                       %Project{socket: ^socket, size: size} ->
                         %Project{ project |
                            processes: processes,
                            size: %{size | height: Panel.max_height(processes, window_size)}
                          }
                       _ -> project
                     end
                   end)
                }
    }
  end

  def update(model, {:start, _process} = _payload) do
    model
  end

  def update(model, {:stop, _process} = _payload) do
    model
  end
end
