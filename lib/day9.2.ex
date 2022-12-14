defmodule AOC.Day9.Puzzle2 do
  def get_visited_positions(input) do
    input
    |> String.trim()
    |> String.split(~r/\n/)
    |> Enum.map(fn movement ->
      movement
      |> String.split(" ")
    end)
    |> Enum.map(fn [dir, count] -> {dir, String.to_integer(count)} end)
    |> move_head({0, 0}, List.duplicate({0, 0}, 9), [{0, 0}])
    |> Enum.count()
  end

  defp move_head([], _, _, positions) do
    positions
  end

  defp move_head([{_, 0} | rest_of_movements], head_position, tail, positions) do
    move_head(rest_of_movements, head_position, tail, positions)
  end

  defp move_head(
         [{"U", amount} | rest_of_movements],
         {xh, yh},
         tail,
         positions
       ) do
    new_head_position = {xh, yh - 1}
    [new_tail_position | rest_of_tail] = get_new_tail(new_head_position, tail)

    with true <- Enum.member?(positions, new_tail_position) do
      move_head(
        [{"U", amount - 1} | rest_of_movements],
        new_head_position,
        Enum.reverse([new_tail_position | rest_of_tail]),
        positions
      )
    else
      _ ->
        move_head(
          [{"U", amount - 1} | rest_of_movements],
          new_head_position,
          Enum.reverse([new_tail_position | rest_of_tail]),
          [
            new_tail_position | positions
          ]
        )
    end
  end

  defp move_head(
         [{"R", amount} | rest_of_movements],
         {xh, yh},
         tail,
         positions
       ) do
    new_head_position = {xh + 1, yh}
    [new_tail_position | rest_of_tail] = get_new_tail(new_head_position, tail)

    with true <- Enum.member?(positions, new_tail_position) do
      move_head(
        [{"R", amount - 1} | rest_of_movements],
        new_head_position,
        Enum.reverse([new_tail_position | rest_of_tail]),
        positions
      )
    else
      _ ->
        move_head(
          [{"R", amount - 1} | rest_of_movements],
          new_head_position,
          Enum.reverse([new_tail_position | rest_of_tail]),
          [
            new_tail_position | positions
          ]
        )
    end
  end

  defp move_head(
         [{"D", amount} | rest_of_movements],
         {xh, yh},
         tail,
         positions
       ) do
    new_head_position = {xh, yh + 1}
    [new_tail_position | rest_of_tail] = get_new_tail(new_head_position, tail)

    with true <- Enum.member?(positions, new_tail_position) do
      move_head(
        [{"D", amount - 1} | rest_of_movements],
        new_head_position,
        Enum.reverse([new_tail_position | rest_of_tail]),
        positions
      )
    else
      _ ->
        move_head(
          [{"D", amount - 1} | rest_of_movements],
          new_head_position,
          Enum.reverse([new_tail_position | rest_of_tail]),
          [
            new_tail_position | positions
          ]
        )
    end
  end

  defp move_head(
         [{"L", amount} | rest_of_movements],
         {xh, yh},
         tail,
         positions
       ) do
    new_head_position = {xh - 1, yh}
    [new_tail_position | rest_of_tail] = get_new_tail(new_head_position, tail)

    with true <- Enum.member?(positions, new_tail_position) do
      move_head(
        [{"L", amount - 1} | rest_of_movements],
        new_head_position,
        Enum.reverse([new_tail_position | rest_of_tail]),
        positions
      )
    else
      _ ->
        move_head(
          [{"L", amount - 1} | rest_of_movements],
          new_head_position,
          Enum.reverse([new_tail_position | rest_of_tail]),
          [
            new_tail_position | positions
          ]
        )
    end
  end

  defp get_new_tail(head_position, tail, new_tail \\ [])

  defp get_new_tail(_, [], new_tail), do: new_tail

  defp get_new_tail({xh, yh}, [{xt, yt} | rest_of_tail], new_tail) do
    x =
      cond do
        xh == xt -> xt
        yh > yt + 1 and xh > xt + 1 -> xh - 1
        yh > yt + 1 and xh < xt - 1 -> xh + 1
        yh < yt - 1 and xh > xt + 1 -> xh - 1
        yh < yt - 1 and xh < xt - 1 -> xh + 1
        yh > yt + 1 -> xh
        yh < yt - 1 -> xh
        xh > xt -> xh - 1
        xh < xt -> xh + 1
        true -> xt
      end

    y =
      cond do
        yh == yt -> yt
        xh > xt + 1 and yh > yt + 1 -> yh - 1
        xh > xt + 1 and yh < yt - 1 -> yh + 1
        xh < xt - 1 and yh > yt + 1 -> yh - 1
        xh < xt - 1 and yh < yt - 1 -> yh + 1
        xh > xt + 1 -> yh
        xh < xt - 1 -> yh
        yh > yt -> yh - 1
        yh < yt -> yh + 1
        true -> yt
      end

    get_new_tail({x, y}, rest_of_tail, [{x, y} | new_tail])
  end
end
