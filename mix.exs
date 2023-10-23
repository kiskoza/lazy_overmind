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
      {:jason, "~> 1.4"},
      {:ratatouille, "~> 0.5.1"}
    ]
  end
end
