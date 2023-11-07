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

  def update(%{projects: %{list: list} = projects} = model, {:start_procfile, {socket, procfile}} = _payload) do
    %{ model |
       projects: %{projects |
                   list: list
                         |> Enum.map(fn project ->
                           case project do
                             %Project{procfile: ^procfile} -> %Project{project | socket: socket, status: :running}
                             _ -> project
                           end
                         end)
                 }
    }
  end

  def update(%{projects: %{list: list} = projects} = model, {:stop_procfile, {socket, procfile}} = _payload) do
    %{ model |
       projects: %{projects |
                   list: list
                         |> Enum.map(fn project ->
                           case project do
                             %Project{procfile: ^procfile} -> %Project{project | socket: nil, status: :stopped}
                             _ -> project
                           end
                         end)
                 }
    }
  end
end
