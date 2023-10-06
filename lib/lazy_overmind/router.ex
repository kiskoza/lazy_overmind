defmodule LazyOvermind.Router do
  alias LazyOvermind.Controllers.Tick

  def update(model, msg) do
    case msg do
      {:callback, {:status, list}} -> %{model | status: %{list: list}}

      :tick -> Tick.update(model, msg)
      _ -> msg
    end
  end
end
