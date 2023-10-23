defmodule LazyOvermind.App do
  @behaviour Ratatouille.App

  alias Ratatouille.Runtime.Subscription

  alias LazyOvermind.Router
  alias LazyOvermind.Views.Window
  alias LazyOvermind.Utils.Config

  @impl true
  def init(%{window: window} = _context) do
    %{
      panel: :projects,
      projects: %{
        list: [],
        position: 0
        },
      window: window
    }
    |> Map.merge(Config.read_json(Config.config_file_path), &Config.resolve_merge/3)
  end

  @impl true
  def update(model, msg) do
    Router.update(model, msg)
  end


  @impl true
  def render(model) do
    Window.render(model)
  end

  @impl true
  def subscribe(_model) do
    Subscription.interval(1_000, :tick)
  end
end
