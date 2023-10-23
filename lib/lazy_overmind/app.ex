defmodule LazyOvermind.App do
  @behaviour Ratatouille.App

  alias Ratatouille.Runtime.Subscription

  alias LazyOvermind.Router
  alias LazyOvermind.Views.Window

  @impl true
  def init(%{window: window} = _context) do
    %{
      panel: :projects,
      projects: %{
        list: [
          %{
            name: "Test Project",
            active: true,
            socket: ".overmind.sock",
            status: %{
              list: nil,
              position: 0,
            },
            size: %{
              height: 5
            }
          }
        ],
        position: 0
      },
      window: window
    }
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
