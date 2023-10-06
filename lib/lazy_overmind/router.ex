defmodule LazyOvermind.Router do
  alias LazyOvermind.Controllers.{Callback, Keyboard, Tick}

  def update(model, msg) do
    case msg do
      {:event, payload} -> Keyboard.update(model, payload)
      {:callback, payload} -> Callback.update(model, payload)
      :tick -> Tick.update(model, nil)
      _ -> msg
    end
  end
end
