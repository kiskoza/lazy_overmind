defmodule LazyOvermind.Views.StatusPanel do
  import Ratatouille.View

  def render(%{status: status} = _model) do
    panel title: "Status" do
      case status do
        %{list: nil} ->
          label(content: "Loading...")
        %{list: list} ->
          list
          |>Enum.map(fn [process, _pid, status | _] ->
            row do
              column size: 6 do
                label(content: process)
              end
              column size: 4 do
                label(content: status)
              end
            end
          end)
        _ ->
          label(content: "UNKNOWN STATUS")
      end
    end
  end
end
