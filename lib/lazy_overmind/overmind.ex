defmodule LazyOvermind.Overmind do
  def start(socket, process) do
    overmind(socket, ["restart", process])
    process
  end

  def status(socket) do
    overmind(socket, ["status"])
    |> String.trim()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&String.split/1)
  end

  def stop(socket, process) do
    overmind(socket, ["stop", process])
    process
  end

  defp overmind(socket, args) do
    {output, 0} = System.cmd("overmind", args ++ ["--socket", socket], stderr_to_stdout: true)
    output
  end
end