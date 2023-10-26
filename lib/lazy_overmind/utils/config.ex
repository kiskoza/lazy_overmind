defmodule LazyOvermind.Utils.Config do
  alias LazyOvermind.Models.{ProjectStatus, Project}

  def config_file_path do
    case System.argv()
         |> OptionParser.parse(strict: [config: :string]) do
      {[config: config], _, _} -> config
      _ -> Path.expand("~/.config/lazyovermind/config.json")
    end
  end

  def read_json(file_path) do
    case File.read(file_path) do
      {:ok, data} ->
        with {:ok, json} <- Jason.decode(data, keys: :atoms) do
          json
        else
          _ -> %{}
        end
      _ -> %{}
    end
  end

  def write_json(data, file_path) do
    with {:ok, json} <- Jason.encode(data, pretty: true) do
      File.write(file_path, json)
    end
  end

  def resolve_merge(key, default_value, config_value) do
    case key do
      :projects ->
        with %{ list: list } <- config_value do
          config_value =
            %{config_value |
              list: list
                    |> Enum.map(fn project ->
                      struct(Project, project)
                    end)
                    |> Enum.map(fn project ->
                      case project do
                        %{visibility: visibility} when is_bitstring(visibility) -> %Project{project | visibility: String.to_atom(visibility)}
                        _ -> %{project | visibility: :hidden}
                      end
                    end)
                    |> Enum.map(fn project ->
                      %Project{project | status: %ProjectStatus{}}
                    end)
            }
          Map.merge(default_value, config_value)
        end

      _ -> default_value
    end
  end
end
