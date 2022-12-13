defmodule AOC.Day8.Puzzle1 do
  def get_visible_trees(forest) do
    tree_matrix =
      forest
      |> String.trim()
      |> String.split(~r/\n/)
      |> Enum.map(
        &(Regex.scan(~r/\d/, &1)
          |> List.flatten()
          |> Enum.map(fn tree -> String.to_integer(tree) end))
      )

    tree_matrix_with_index =
      tree_matrix
      |> Enum.map(&Enum.with_index/1)
      |> Enum.with_index()

    tree_matrix_with_index
    |> Enum.map(fn {tree_row, y} ->
      tree_row |> Enum.map(fn {_, x} -> is_visible({x, y}, tree_matrix) end)
    end)
    |> List.flatten()
    |> Enum.filter(fn visible -> visible end)
    |> Enum.count()
  end

  defp is_visible({tree_x, tree_y} = tree, forest) do
    cond do
      is_blocked_from_x(tree, {0, tree_y}, forest) and
        is_blocked_from_x(tree, {tree_x + 1, tree_y}, forest) and
        is_blocked_from_y(tree, {tree_x, 0}, forest) and
          is_blocked_from_y(tree, {tree_x, tree_y + 1}, forest) ->
        false

      true ->
        true
    end
  end

  defp is_blocked_from_x({tree_x, _}, {x_index, _}, _) when tree_x == x_index, do: false

  defp is_blocked_from_x({tree_x, tree_y} = tree, {x_index, y_index}, forest) do
    tree_height = Enum.at(forest, tree_y, []) |> Enum.at(tree_x)
    neighboring_tree = Enum.at(forest, y_index, []) |> Enum.at(x_index)

    cond do
      neighboring_tree == nil -> false
      neighboring_tree >= tree_height -> true
      true -> is_blocked_from_x(tree, {x_index + 1, y_index}, forest)
    end
  end

  defp is_blocked_from_y({_, tree_y}, {_, y_index}, _) when tree_y == y_index, do: false

  defp is_blocked_from_y({tree_x, tree_y} = tree, {x_index, y_index}, forest) do
    tree_height = Enum.at(forest, tree_y, []) |> Enum.at(tree_x)
    neighboring_tree = Enum.at(forest, y_index, []) |> Enum.at(x_index)

    cond do
      neighboring_tree == nil -> false
      neighboring_tree >= tree_height -> true
      true -> is_blocked_from_y(tree, {x_index, y_index + 1}, forest)
    end
  end
end
