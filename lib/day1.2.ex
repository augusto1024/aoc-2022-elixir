defmodule AOC.Day1.Puzzle2 do
  alias AOC.Day1.Puzzle1, as: Day1

  def get_calories_of_top_three_elves(elves_calories) do
    elves_calories
    |> Day1.get_elves_calories()
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(3)
    |> Enum.reduce(0, &(&1 + &2))
  end
end
