defmodule LazyOvermind.Views.StatusPanel do
  import Ratatouille.View
  import Ratatouille.Constants, only: [color: 1]

  @style_selected [
    color: color(:black),
    background: color(:white)
  ]

  def render(%{status: status} = _model) do
    panel title: "Status" do
      case status do
        %{list: nil} ->
          label(content: "Loading...")
        %{list: list, position: position} ->
          table do
            list
            |> Enum.with_index
            |> Enum.map(fn {[process, _pid, status | _], index} ->
              table_row(if(index == position, do: @style_selected, else: [])) do
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
