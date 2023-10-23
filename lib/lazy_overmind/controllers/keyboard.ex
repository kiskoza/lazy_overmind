defmodule LazyOvermind.Controllers.Keyboard do
  alias LazyOvermind.Controllers.{ProjectsKeyboard, StatusKeyboard}

  def update(%{panel: :projects} = model, payload) do
    ProjectsKeyboard.update(model, payload)
  end

  def update(%{panel: :status} = model, payload) do
    StatusKeyboard.update(model, payload)
  end

  def update(model, _payload) do
    model
  end
end
