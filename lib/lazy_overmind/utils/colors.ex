defmodule LazyOvermind.Utils.Colors do
  import Ratatouille.Constants, only: [color: 1]

  def selected(apply, visibility) do
    case {apply, visibility} do
      {true, :focused} ->
        [
          color: color(:black),
          background: color(:cyan)
        ]

      {true, :visible} ->
        [
          color: color(:black),
          background: color(:white)
        ]

      _ -> []
    end
  end

  def stopped(apply) do
    case apply do
      true -> [color: color(:red)]
      _ -> []
    end
  end
end
