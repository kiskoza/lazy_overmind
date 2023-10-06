defmodule LazyOvermind.Controllers.Callback do
  def update(%{status: status} = model, {:status, list} = _payload) do
    %{model | status: %{status | list: list}}
  end

  def update(model, {:start, _process} = _payload) do
    model
  end

  def update(model, {:stop, _process} = _payload) do
    model
  end
end
