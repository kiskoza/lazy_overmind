defmodule LazyOvermind.Views.Window do
  import Ratatouille.View

  alias LazyOvermind.Views.{ProjectsPanel, StatusPanel}

  def render(%{projects: %{list: project_list} = _projects} = model) do
    view do
      row do
        column(size: 3) do
          ProjectsPanel.render(model)
        end
        column(size: 9) do
          project_list
          |> Enum.filter(fn %{active: active} = _project -> active end)
          |> Enum.map(fn project -> StatusPanel.render(project, model) end)
        end
      end
    end
  end
end
