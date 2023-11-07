defmodule LazyOvermind.Utils.Panel do
  import Ratatouille.Constants, only: [key: 1]

  @arrow_up key(:arrow_up)
  @arrow_down key(:arrow_down)

  def max_height(list, %{height: height} = _window_size) do
    [
      Enum.count(list) + 4,
      height
    ]
    |> Enum.min
  end

  def new_position(position, list, key) do
    case key do
      @arrow_up -> max(0, position - 1)
      @arrow_down -> min(Enum.count(list || []) - 1, position + 1)
      _ -> position
    end
  end

  def offset(list, height, position) do
    height_2 = trunc(height / 2)
    count = Enum.count(list)

    cond do
      position <= height_2 -> 0
      count - position > height - height_2 -> position - height_2
      true -> max(0, count - height)
    end
  end
end
