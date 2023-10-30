defmodule LazyOvermind.Controllers.OpenFileKeyboard do
  import Ratatouille.Constants, only: [key: 1]

  alias LazyOvermind.Utils.{FileBrowser, Panel}

  @arrow_up key(:arrow_up)
  @arrow_down key(:arrow_down)
  @escape key(:esc)
  @enter key(:enter)

  def update(%{files: %{position: position, root: root} = files} = model, %{key: key} = _payload)
  when key == @arrow_up or key == @arrow_down do
    list = FileBrowser.list(root)

    %{model |
      files: %{ files |
                list: list,
                position: Panel.new_position(position, list, key)
             }
    }
  end

  def update(%{files: %{position: position, root: root, list: list} = files} = model, %{key: key} = _payload)
  when key == @enter do
    file_or_dir = Enum.at(list, position)
                  |> String.replace_leading("📁 ", "")
                  |> String.replace_leading("📄 ", "")
                  |> Kernel.then(fn file -> "#{root}/#{file}" end)
                  |> Path.expand

    with true <- File.dir?(file_or_dir) do
      %{model |
        files: %{ files |
                  root: file_or_dir,
                  list: FileBrowser.list(file_or_dir),
                  position: 0
               }
      }
    else _ -> model
    end
  end

  def update(model, %{key: key} = _payload)
  when key == @escape do
    %{model | focus: :projects}
  end

  def update(model, _payload) do
    model
  end
end
