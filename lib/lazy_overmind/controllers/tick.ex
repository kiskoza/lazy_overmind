defmodule LazyOvermind.Controllers.Tick do
  alias LazyOvermind.Commands.Status

  def update(model, :tick) do
    {model, Status.command(model)}
  end
end
