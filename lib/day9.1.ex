defmodule AOC.Day9.Puzzle1 do
  def get_visited_positions(input) do
    input
    |> String.trim()
    |> String.split(~r/\n/)
    |> Enum.map(fn movement ->
      movement
      |> String.split(" ")
    end)
    |> Enum.map(fn [dir, count] -> {dir, String.to_integer(count)} end)
    |> move_head({0, 0}, {0, 0}, [{0, 0}])
    |> Enum.count()
  end

  defp move_head([], _, _, positions) do
    positions
  end

  defp move_head([{_, 0} | rest_of_movements], head_position, tail_position, positions) do
    move_head(rest_of_movements, head_position, tail_position, positions)
  end

  defp move_head(
         [{"U", amount} | rest_of_movements],
         {xh, yh},
         tail_position,
         positions
       ) do
    new_head_position = {xh, yh - 1}
    new_tail_position = get_tail_position(new_head_position, tail_position)

    with true <- Enum.member?(positions, new_tail_position) do
      move_head(
        [{"U", amount - 1} | rest_of_movements],
        new_head_position,
        new_tail_position,
        positions
      )
    else
      _ ->
        move_head([{"U", amount - 1} | rest_of_movements], new_head_position, new_tail_position, [
          new_tail_position | positions
        ])
    end
  end

  defp move_head(
         [{"R", amount} | rest_of_movements],
         {xh, yh},
         tail_position,
         positions
       ) do
    new_head_position = {xh + 1, yh}
    new_tail_position = get_tail_position(new_head_position, tail_position)

    with true <- Enum.member?(positions, new_tail_position) do
      move_head(
        [{"R", amount - 1} | rest_of_movements],
        new_head_position,
        new_tail_position,
        positions
      )
    else
      _ ->
        move_head([{"R", amount - 1} | rest_of_movements], new_head_position, new_tail_position, [
          new_tail_position | positions
        ])
    end
  end

  defp move_head(
         [{"D", amount} | rest_of_movements],
         {xh, yh},
         tail_position,
         positions
       ) do
    new_head_position = {xh, yh + 1}
    new_tail_position = get_tail_position(new_head_position, tail_position)

    with true <- Enum.member?(positions, new_tail_position) do
      move_head(
        [{"D", amount - 1} | rest_of_movements],
        new_head_position,
        new_tail_position,
        positions
      )
    else
      _ ->
        move_head([{"D", amount - 1} | rest_of_movements], new_head_position, new_tail_position, [
          new_tail_position | positions
        ])
    end
  end

  defp move_head(
         [{"L", amount} | rest_of_movements],
         {xh, yh},
         tail_position,
         positions
       ) do
    new_head_position = {xh - 1, yh}
    new_tail_position = get_tail_position(new_head_position, tail_position)

    with true <- Enum.member?(positions, new_tail_position) do
      move_head(
        [{"L", amount - 1} | rest_of_movements],
        new_head_position,
        new_tail_position,
        positions
      )
    else
      _ ->
        move_head([{"L", amount - 1} | rest_of_movements], new_head_position, new_tail_position, [
          new_tail_position | positions
        ])
    end
  end

  defp get_tail_position({xh, yh}, {xt, yt}) do
    x =
      cond do
        xh == xt -> xt
        yh > yt + 1 -> xh
        yh < yt - 1 -> xh
        xh > xt -> xh - 1
        xh < xt -> xh + 1
        true -> xt
      end

    y =
      cond do
        yh == yt -> yt
        xh > xt + 1 -> yh
        xh < xt - 1 -> yh
        yh > yt -> yh - 1
        yh < yt -> yh + 1
        true -> yt
      end

    {x, y}
  end
end
