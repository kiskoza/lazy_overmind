defmodule LazyOvermind.Models.Project do
  alias LazyOvermind.Models.ProjectStatus

  defstruct [
    :name,
    size: %{ height: 5 },
    socket: nil,
    status: %ProjectStatus{},
    visibility: :hidden,
  ]
end
