defmodule AOC.Day6.Puzzle2 do
  alias AOC.Day6.Puzzle1, as: Day6

  def get_start_of_message(message) do
    message
    |> String.trim()
    |> String.to_charlist()
    |> Day6.find_marker(14)
  end
end
