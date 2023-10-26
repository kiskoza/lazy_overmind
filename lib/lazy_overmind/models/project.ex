defmodule LazyOvermind.Models.Project do
  defstruct [
    :name,
    size: %{ height: 5 },
    socket: nil,
    processes: nil,
    processes_cursor: 0,
    visibility: :hidden,
  ]
end
