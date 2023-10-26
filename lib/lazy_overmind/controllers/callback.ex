defmodule LazyOvermind.Controllers.Callback do
  alias LazyOvermind.Utils.Panel

  alias LazyOvermind.Models.{ProjectStatus, Project}

  def update(%{projects: %{list: project_list} = projects, window: window_size} = model, {:status, {socket, list}} = _payload) do
    %{model |
      projects: %{ projects |
                   list: project_list
                   |> Enum.map(fn project ->
                     case project do
                       %Project{socket: ^socket, status: status, size: size} ->
                         %Project{ project |
                            status: %ProjectStatus{ status | list: list},
                            size: %{size | height: Panel.max_height(list, window_size)}
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
