defmodule LazyOvermind.Controllers.Resize do
  alias LazyOvermind.Utils.Panel

  alias LazyOvermind.Models.Project

  def update(%{projects: %{list: project_list} = projects, window: window} = model, %{w: width, h: height} = _payload) do
    %{model |
      projects: %{projects |
                  list: project_list
                        |> Enum.map(fn %Project{size: size, status: %{list: list} = _status} = project ->
                          %Project{project | size: %{size | height: Panel.max_height(list, %{height: height}) }}
                        end)
                },
      window: %{window |
                width: width,
                height: height}
    }
  end
end
