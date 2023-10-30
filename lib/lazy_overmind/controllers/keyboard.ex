defmodule LazyOvermind.Controllers.Keyboard do
  alias LazyOvermind.Controllers.{OpenFileKeyboard, ProjectsKeyboard, StatusKeyboard}

  def update(%{focus: :projects} = model, payload) do
    ProjectsKeyboard.update(model, payload)
  end

  def update(%{focus: :status} = model, payload) do
    StatusKeyboard.update(model, payload)
  end

  def update(%{focus: :open} = model, payload) do
    OpenFileKeyboard.update(model, payload)
  end

  def update(model, _payload) do
    model
  end
end
