defmodule LazyOvermind.Utils.Panel do
  def max_height(list, %{height: height} = _window_size) do
    [
      Enum.count(list) + 4,
      height
    ]
    |> Enum.min
  end

  def offset(list, height, position) do
    height_2 = trunc(height / 2)
    count = Enum.count(list)

    cond do
      position <= height_2 -> 0
      count - position > height - height_2 -> position - height_2
      true -> count - height
    end
  end
end
