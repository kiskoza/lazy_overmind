defmodule LazyOvermind.Controllers.Callback do
  alias LazyOvermind.Utils.Panel

  def update(%{status: %{size: size} = status, window: window_size} = model, {:status, list} = _payload) do
    %{model |
      status: %{status |
                list: list,
                size: %{size |
                        height: Panel.max_height(list, window_size)}
              }
    }
  end

  def update(model, {:start, _process} = _payload) do
    model
  end

  def update(model, {:stop, _process} = _payload) do
    model
  end
end
