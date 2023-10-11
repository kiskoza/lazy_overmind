defmodule LazyOvermind.Views.ProjectsPanel do
  import Ratatouille.View
  import Ratatouille.Constants, only: [color: 1]

  alias LazyOvermind.Utils.Panel

  @style_selected [
    color: color(:black),
    background: color(:white)
  ]

  def render(%{window: %{height: height} = _window, projects: projects} = _model) do
    panel title: "Projects",
          height: height do
      case projects do
        %{list: nil} ->
          label(content: "No project found.")
        %{list: list, position: position} ->
          offset = Panel.offset(list, height - 4, position)

          table do
            list
            |> Enum.drop(offset)
            |> Enum.with_index(offset)
            |> Enum.map(fn {%{name: name}, index} ->
              table_row(if(index == position, do: @style_selected, else: [])) do
                table_cell(content: name)
              end
            end)
          end
        _ ->
          label(content: "UNKNOWN STATUS")
      end
    end
  end
end
