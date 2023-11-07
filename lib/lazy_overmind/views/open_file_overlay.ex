defmodule LazyOvermind.Views.OpenFileOverlay do
  import Ratatouille.View

  alias LazyOvermind.Utils.{Colors, Panel}

  def render(%{window: %{height: height} = _window, files: %{root: root, position: position, list: list} = _files} = _model) do
    height = height - 2*5
    offset = Panel.offset(list, height - 4, position)

    overlay padding: 5 do
      panel title: "Open",
            height: height do
        tree do
          tree_node content: root do
            list
            |> Enum.drop(offset)
            |> Enum.take(height - 4)
            |> Enum.with_index(offset)
            |> Enum.map(fn {file, index} ->
              tree_node(
                [content: file] ++
                Colors.selected(position == index, :focused)
              )
            end)
          end
        end
      end
    end
  end
end
