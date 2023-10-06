defmodule LazyOvermind.Controllers.Keyboard do
  import Ratatouille.Constants, only: [key: 1]

  alias LazyOvermind.Commands.{Start, Stop}

  @arrow_up key(:arrow_up)
  @arrow_down key(:arrow_down)

  def update(%{status: %{position: position, list: list} = status} = model, %{key: key} = _payload)
  when key == @arrow_up or key == @arrow_down do
    %{model | status: %{status | position: new_position(position, list, key)}}
  end

  def update(model, %{ch: ch} = _payload)
  when ch == ?x or ch == ?X do
    {model, Stop.command(model)}
  end

  def update(model, %{ch: ch} = _payload)
  when ch == ?s or ch == ?S do
    {model, Start.command(model)}
  end

  def update(model, _payload) do
    model
  end

  defp new_position(position, list, key) do
    case key do
      @arrow_up -> max(0, position - 1)
      @arrow_down -> min(Enum.count(list || []) - 1, position + 1)
      _ -> position
    end
  end
end
