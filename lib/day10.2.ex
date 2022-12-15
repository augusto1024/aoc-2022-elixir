defmodule AOC.Day10.Puzzle2 do
  alias AOC.Day10.Puzzle1, as: Day10

  def get_crt_image(program) do
    program
    |> String.trim()
    |> String.split(~r/\n/)
    |> Day10.execute_program(&draw_image/3)
    |> Enum.filter(&(Enum.count(&1) > 0))
    |> Enum.reverse()
    |> Enum.map(&Enum.join/1)

    # |> Enum.map(fn {cycle, x} -> cycle * x end)
    # |> Enum.sum()
  end

  defp draw_image([], cycle, x), do: draw_image([[]], cycle, x)

  defp draw_image(list, cycle, x) do
    current_line =
      List.duplicate(".", max(0, x - 1)) ++
        List.duplicate("#", 3) ++ List.duplicate(".", max(min(37, 37 - x), 0))

    if Enum.at(current_line, rem(cycle - 1, 40)) == "#" do
      update_image("#", list)
    else
      update_image(".", list)
    end
  end

  defp update_image(char, [row | rest_of_image]) do
    if Enum.count(row) === 40 do
      [[char], row | rest_of_image]
    else
      [row ++ [char] | rest_of_image]
    end
  end
end
