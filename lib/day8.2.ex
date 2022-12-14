defmodule AOC.Day8.Puzzle2 do
  alias AOC.Day8.Puzzle1, as: Day8

  def get_scenic_scores(forest) do
    tree_matrix = Day8.get_tree_matrix(forest)

    tree_matrix_with_index =
      tree_matrix
      |> Enum.map(&Enum.with_index/1)
      |> Enum.with_index()

    tree_matrix_with_index
    |> Enum.map(fn {tree_row, y} ->
      tree_row |> Enum.map(fn {_, x} -> calc_scenic_score({x, y}, tree_matrix) end)
    end)
    |> List.flatten()
    |> Enum.max()
  end

  defp calc_scenic_score({tree_x, tree_y} = tree, forest) do
    calc_scenic_score_from_x(tree, {tree_x - 1, tree_y}, forest) *
      calc_scenic_score_from_x(tree, {tree_x + 1, tree_y}, forest) *
      calc_scenic_score_from_y(tree, {tree_x, tree_y - 1}, forest) *
      calc_scenic_score_from_y(tree, {tree_x, tree_y + 1}, forest)
  end

  defp calc_scenic_score_from_x({tree_x, _}, {x_index, _}, _)
       when tree_x == x_index or x_index < 0,
       do: 0

  defp calc_scenic_score_from_x({tree_x, tree_y} = tree, {x_index, y_index}, forest) do
    tree_height = Enum.at(forest, tree_y, []) |> Enum.at(tree_x)
    neighboring_tree = Enum.at(forest, y_index, []) |> Enum.at(x_index)

    cond do
      neighboring_tree == nil -> 0
      neighboring_tree >= tree_height -> 1
      x_index > tree_x -> 1 + calc_scenic_score_from_x(tree, {x_index + 1, y_index}, forest)
      x_index < tree_x -> 1 + calc_scenic_score_from_x(tree, {x_index - 1, y_index}, forest)
    end
  end

  defp calc_scenic_score_from_y({_, tree_y}, {_, y_index}, _)
       when tree_y == y_index or y_index < 0,
       do: 0

  defp calc_scenic_score_from_y({tree_x, tree_y} = tree, {x_index, y_index}, forest) do
    tree_height = Enum.at(forest, tree_y, []) |> Enum.at(tree_x)
    neighboring_tree = Enum.at(forest, y_index, []) |> Enum.at(x_index)

    cond do
      neighboring_tree == nil -> 0
      neighboring_tree >= tree_height -> 1
      y_index > tree_y -> 1 + calc_scenic_score_from_y(tree, {x_index, y_index + 1}, forest)
      y_index < tree_y -> 1 + calc_scenic_score_from_y(tree, {x_index, y_index - 1}, forest)
    end
  end
end
