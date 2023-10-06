defmodule LazyOvermind.Controllers.Tick do
  alias LazyOvermind.Commands.Status

  def update(model, _payload) do
    {model, Status.command(model)}
  end
end
