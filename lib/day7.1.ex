defmodule AOC.Day7.Puzzle1 do
  def generate_tree(commands) do
    commands
    |> String.trim()
    |> String.split(~r/\n/)
    |> inspect_commands()
    |> Map.get("/")
    |> tree_to_list()
    |> IO.inspect()
    |> flatten_sizes()
  end

  defp get_dir_sizes(sizes, total \\ 0)

  defp get_dir_sizes(sizes, total) when is_number(sizes) do
    sizes
  end

  defp flatten_sizes([]) do
    []
  end

  defp flatten_sizes([_ | []] = size) do
    size
  end

  defp flatten_sizes([node | rest_of_tree]) do
    [flatten_sizes(node) | flatten_sizes(rest_of_tree)]
  end

  defp flatten_sizes({_, node_value}) do
    flatten_sizes(node_value)
  end

  defp flatten_sizes(size = size) do
    [size]
  end

  defp tree_to_list(%{} = tree) do
    list =
      tree
      |> Enum.to_list()
      |> Enum.map(&do_tree_to_list(&1))

    list
    |> Enum.filter(&is_tuple(&1))
    |> Enum.concat([
      list
      |> Enum.filter(fn elem -> is_number(elem) end)
      |> Enum.sum()
    ])
  end

  defp do_tree_to_list({key, %{} = value}) do
    {key, tree_to_list(value)}
  end

  defp do_tree_to_list({_, value}) do
    value
  end

  defp inspect_commands(commands, path \\ [], tree \\ %{})

  defp inspect_commands([], _, tree) do
    tree
  end

  defp inspect_commands(["$ cd .." | rest_of_commands], path, tree) do
    inspect_commands(rest_of_commands, Enum.take(path, Enum.count(path) - 1), tree)
  end

  defp inspect_commands(["$ cd " <> file_name | rest_of_commands], path, tree) do
    new_path = path ++ [file_name]
    tree = put_in(tree, new_path, %{})
    inspect_commands(rest_of_commands, new_path, tree)
  end

  defp inspect_commands(["dir " <> _ | rest_of_commands], path, tree) do
    inspect_commands(rest_of_commands, path, tree)
  end

  defp inspect_commands(["$ ls" | rest_of_commands], path, tree) do
    inspect_commands(rest_of_commands, path, tree)
  end

  defp inspect_commands([file | rest_of_commands], path, tree) do
    [size, file_name] = String.split(file, " ")
    current_dir = get_in(tree, path)
    tree = put_in(tree, path, Map.put(current_dir, file_name, String.to_integer(size)))
    inspect_commands(rest_of_commands, path, tree)
  end
end
