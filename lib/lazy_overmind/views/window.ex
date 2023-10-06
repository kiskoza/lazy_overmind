defmodule LazyOvermind.Views.Window do
  import Ratatouille.View

  alias LazyOvermind.Views.StatusPanel

  def render(model) do
    view do
      row do
        column(size: 3) do
          StatusPanel.render(model)
        end
      end
    end
  end
end
