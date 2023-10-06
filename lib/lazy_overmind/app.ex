defmodule LazyOvermind.App do
  @behaviour Ratatouille.App

  alias Ratatouille.Runtime.Subscription

  alias LazyOvermind.Router
  alias LazyOvermind.Views.Window

  @impl true
  def init(_context) do
    %{
      socket: ".overmind.sock",
      status: %{
        list: nil,
        position: 0
      }
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
