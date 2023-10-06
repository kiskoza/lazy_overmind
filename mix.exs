defmodule LazyOvermind.MixProject do
  use Mix.Project

  def project do
    [
      app: :lazy_overmind,
      version: "0.0.1",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {LazyOvermind, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ratatouille, github: "ndreynolds/ratatouille"}
    ]
  end
end
