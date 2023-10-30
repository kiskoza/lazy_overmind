defmodule LazyOvermind.Views.ProjectsPanel do
  import Ratatouille.View

  alias LazyOvermind.Utils.{Colors, Panel}

  def render(%{window: %{height: height} = _window, projects: projects, focus: panel} = _model) do
    panel title: "Projects",
          height: height do
      case projects do
        %{list: nil} ->
          label(content: "No project found.")
        %{list: list, position: position} ->
          offset = Panel.offset(list, height - 4, position)
          visibility = if(panel == :projects, do: :focused, else: :visible)

          table do
            list
            |> Enum.drop(offset)
            |> Enum.with_index(offset)
            |> Enum.map(fn {%{name: name}, index} ->
              table_row(if(index == position, do: Colors.selected(visibility), else: [])) do
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
