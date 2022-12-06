defmodule AOC.Day1.Puzzle1 do
  def get_elves_calories(elves_calories) do
    elves_calories
    |> String.trim()
    |> String.split(~r/[^\d]\n/)
    |> Enum.map(
      &(String.split(&1, ~r/[^\d]/)
        |> Enum.map(fn calory -> String.to_integer(calory) end)
        |> Enum.reduce(0, fn calory, total -> calory + total end))
    )
  end

  def get_calories_of_top_elf(elves_calories) do
    elves_calories
    |> get_elves_calories()
    |> Enum.max()
  end
end
