defmodule LazyOvermind.Controllers.Resize do
  alias LazyOvermind.Utils.Panel

  def update(%{status: %{list: list, size: size} = status, window: window} = model, %{w: width, h: height} = _payload) do
    %{model |
      status: %{status |
                size: %{size |
                        height: Panel.max_height(list, %{height: height})
                      }
              },
      window: %{window |
                width: width,
                height: height}
    }
  end
end
