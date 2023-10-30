defmodule LazyOvermind.Controllers.StatusKeyboard do
  import Ratatouille.Constants, only: [key: 1]

  alias LazyOvermind.Commands.{Connect, Start, Stop}
  alias LazyOvermind.Models.Project
  alias LazyOvermind.Utils.Panel

  @arrow_up key(:arrow_up)
  @arrow_down key(:arrow_down)
  @arrow_left key(:arrow_left)

  def update(%{projects: %{list: project_list, position: position} = projects} = model, %{key: key} = _payload)
  when key == @arrow_up or key == @arrow_down do
    %{model |
      projects: %{ projects |
                   list: project_list
                   |> Enum.with_index
                   |> Enum.map(fn {%Project{processes: processes, processes_cursor: processes_cursor} = project, index} ->
                     case index do
                       ^position ->
                         %Project{ project |
                                   processes_cursor: Panel.new_position(processes_cursor, processes, key)
                          }
                       _ -> project
                     end
                   end)
                }
    }
  end

  def update(%{projects: %{list: project_list} = projects} = model, %{key: key} = _payload)
  when key == @arrow_left do
    %{model |
      focus: :projects,
      projects: %{ projects |
                   list: project_list
                   |> Enum.map(fn %Project{visibility: visibility} = project ->
                     case visibility do
                       :focused -> %Project{ project | visibility: :visible }
                        _ -> project
                      end
                   end)
                }
    }
  end

  def update(%{projects: %{list: list, position: position} = _projects } = model, %{ch: ch} = _payload)
  when ch == ?c or ch == ?C do
    {model, Connect.command(Enum.at(list, position), model)}
  end

  def update(%{projects: %{list: list, position: position} = _projects } = model, %{ch: ch} = _payload)
  when ch == ?x or ch == ?X do
    {model, Stop.command(Enum.at(list, position), model)}
  end

  def update(%{projects: %{list: list, position: position} = _projects } = model, %{ch: ch} = _payload)
  when ch == ?s or ch == ?S do
    {model, Start.command(Enum.at(list, position), model)}
  end

  def update(model, _payload) do
    model
  end
end
