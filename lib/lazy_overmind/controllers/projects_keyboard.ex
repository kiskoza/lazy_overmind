defmodule LazyOvermind.Controllers.ProjectsKeyboard do
  import Ratatouille.Constants, only: [key: 1]

  alias LazyOvermind.Models.Project

  @arrow_up key(:arrow_up)
  @arrow_down key(:arrow_down)
  @arrow_right key(:arrow_right)

  def update(%{projects: %{list: list, position: position} = projects} = model, %{key: key} = _payload)
  when key == @arrow_up or key == @arrow_down do
    %{model |
      projects: %{ projects |
                   position: new_position(position, list, key)
                }
    }
  end

  def update(%{projects: %{list: project_list, position: position} = projects} = model, %{key: key} = _payload)
  when key == @arrow_right do
    %{model |
      panel: :status,
      projects: %{ projects |
                   list: project_list
                   |> Enum.with_index
                   |> Enum.map(fn {project, index} ->
                     case index do
                       ^position ->
                         %Project{ project |
                            visibility: :focused
                          }
                       _ -> project
                     end
                   end)
                }
    }
  end

  def update(model, _payload) do
    model
  end

  defp new_position(position, list, key) do
    case key do
      @arrow_up -> max(0, position - 1)
      @arrow_down -> min(Enum.count(list || []) - 1, position + 1)
      _ -> position
    end
  end
end
