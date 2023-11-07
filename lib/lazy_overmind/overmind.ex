defmodule LazyOvermind.Overmind do
  def connect(socket, process) do
    shell = System.get_env("SHELL")
    System.cmd("xfce4-terminal", ["--execute", shell, "-c", "overmind connect #{process} --socket #{socket}"])
    process
  end

  def start(socket, process) do
    overmind(socket, ["restart", process])
    process
  end

  def start_procfile(socket, procfile) do
    overmind(socket, ["start", "-D", "-f", procfile])
    {socket, procfile}
  end

  def stop_procfile(socket, procfile) do
    overmind(socket, ["quit"])
    {socket, procfile}
  end

  def status(socket) do
    {
      socket,
      overmind(socket, ["status"])
        |> String.trim()
        |> String.split("\n")
        |> Enum.drop(1)
        |> Enum.map(&String.split/1)
    }
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
