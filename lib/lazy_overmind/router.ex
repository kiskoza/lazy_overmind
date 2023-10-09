defmodule LazyOvermind.Router do
  alias LazyOvermind.Controllers.{Callback, Keyboard, Resize, Tick}

  def update(model, msg) do
    case msg do
      {:event, payload} -> Keyboard.update(model, payload)
      {:resize, payload} -> Resize.update(model, payload)
      {:callback, payload} -> Callback.update(model, payload)
      :tick -> Tick.update(model, nil)
      _ -> model
    end
  end
end
