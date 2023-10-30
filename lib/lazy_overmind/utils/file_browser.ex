defmodule LazyOvermind.Utils.FileBrowser do
  def list(root) do
    File.ls(root)
    |> Kernel.then(fn {:ok, files} -> files end)
    |> Enum.map(fn file ->
      case File.dir?("#{root}/#{file}") do
        true -> "📁 #{file}"
        _ -> "📄 #{file}"
      end
    end)
    |> Enum.sort
    |> Kernel.then(fn list -> [".." | list] end )
  end
end
