defmodule LazyOvermind.Views.StatusPanel do
  import Ratatouille.View

  alias LazyOvermind.Utils.{Colors, Panel}

  alias LazyOvermind.Models.{ProjectStatus, Project}

  def render(%Project{name: name, status: status, size: %{height: height} = _size, visibility: visibility} = _project, _model) do
    panel title: name,
          height: height do
      case status do
        %ProjectStatus{list: nil} ->
          label(content: "Loading...")
        %ProjectStatus{list: list, position: position} ->
          offset = Panel.offset(list, height - 4, position)

          table do
            list
            |> Enum.drop(offset)
            |> Enum.with_index(offset)
            |> Enum.map(fn {[process, _pid, status | _], index} ->
              table_row(if(index == position, do: Colors.selected(visibility), else: [])) do
                table_cell(content: process)
                table_cell(content: status)
              end
            end)
          end
        _ ->
          label(content: "UNKNOWN STATUS")
      end
    end
  end
end
