defmodule AOC.Day4.Puzzle2 do
  alias AOC.Day4.Puzzle1, as: Day4

  def get_overlapping_pairs(pairs) do
    Day4.get_overlapping_pairs(pairs, totally_overlaped: false)
  end
end
