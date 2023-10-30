defmodule LazyOvermind.Views.Window do
  import Ratatouille.View

  alias LazyOvermind.Views.{OpenFileOverlay, ProjectsPanel, StatusPanel}

  def render(%{focus: focus, projects: %{list: project_list} = _projects} = model) do
    view do
      row do
        column(size: 3) do
          ProjectsPanel.render(model)
        end
        column(size: 9) do
          project_list
          |> Enum.filter(fn %{visibility: visibility} = _project -> visibility != :hidden end)
          |> Enum.map(fn project -> StatusPanel.render(project, model) end)
        end
      end

      with :open <- focus do
        OpenFileOverlay.render(model)
      else _ -> nil
      end
    end
  end
end
