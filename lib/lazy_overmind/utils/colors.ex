defmodule LazyOvermind.Utils.Colors do
  import Ratatouille.Constants, only: [color: 1]

  def selected(visibility) do
    case visibility do
      :focused ->
        [
          color: color(:black),
          background: color(:cyan)
        ]

      :visible ->
        [
          color: color(:black),
          background: color(:white)
        ]
    end
  end
end
