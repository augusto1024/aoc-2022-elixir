defmodule AOC.Day4.Puzzle1 do
  def get_overlapping_pairs(pairs) do
    pairs
    |> String.trim()
    |> String.split(~r/\n/)
    |> Enum.map(
      &(String.split(&1, ",")
        |> Enum.map(fn range ->
          String.split(range, "-")
          |> Enum.map(fn val -> String.to_integer(val) end)
          |> List.to_tuple()
        end))
    )
    |> Enum.reduce(0, fn [p1, p2], overlapped ->
      if are_overlaped?(p1, p2), do: overlapped + 1, else: overlapped
    end)
  end

  defp are_overlaped?({x1, x2}, {y1, y2}) do
    cond do
      y1 >= x1 and y2 <= x2 -> true
      x1 >= y1 and x2 <= y2 -> true
      true -> false
    end
  end
end
