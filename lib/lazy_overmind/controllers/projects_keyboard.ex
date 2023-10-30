defmodule LazyOvermind.Controllers.ProjectsKeyboard do
  import Ratatouille.Constants, only: [key: 1]

  alias LazyOvermind.Models.Project
  alias LazyOvermind.Utils.{FileBrowser, Panel}

  @arrow_up key(:arrow_up)
  @arrow_down key(:arrow_down)
  @arrow_right key(:arrow_right)

  def update(%{projects: %{list: list, position: position} = projects} = model, %{key: key} = _payload)
  when key == @arrow_up or key == @arrow_down do
    %{model |
      projects: %{ projects |
                   position: Panel.new_position(position, list, key)
                }
    }
  end

  def update(%{projects: %{list: project_list, position: position} = projects} = model, %{key: key} = _payload)
  when key == @arrow_right do
    %{model |
      focus: :status,
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

  def update(model, %{ch: ch} = _payload)
  when ch == ?o or ch == ?O do
    root = File.cwd() |> Kernel.then(fn {:ok, cwd} -> cwd end)

    %{model |
      focus: :open,
      files: %{
        root: root,
        list: FileBrowser.list(root),
        position: 0
      }
    }
  end

  def update(model, _payload) do
    model
  end
end
