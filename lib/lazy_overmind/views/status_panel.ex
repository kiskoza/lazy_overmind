defmodule LazyOvermind.Views.StatusPanel do
  import Ratatouille.View

  alias LazyOvermind.Utils.{Colors, Panel}

  alias LazyOvermind.Models.Project

  def render(%Project{name: name, size: %{height: height} = _size, visibility: visibility} = project, _model) do
    panel title: name,
          height: height do
      case project do
        %{status: :stopped} ->
          label(content: "Not running yet...")

        %{processes: nil} ->
          label(content: "Loading...")

        %{processes: list, processes_cursor: position} ->
          offset = Panel.offset(list, height - 4, position)

          table do
            list
            |> Enum.drop(offset)
            |> Enum.take(height - 4)
            |> Enum.with_index(offset)
            |> Enum.map(fn {[process, _pid, status | _], index} ->
              table_row(Colors.selected(index == position, visibility)) do
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
