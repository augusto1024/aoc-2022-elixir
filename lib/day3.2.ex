defmodule AOC.Day3.Puzzle2 do
  alias AOC.Day3.Puzzle1, as: Day3

  def get_item_type_badges(rucksacks) do
    rucksacks
    |> String.trim()
    |> String.split(~r/\n/)
    |> Enum.map(fn rucksack ->
      rucksack
      |> String.to_charlist()
      |> Enum.uniq()
    end)
    |> Enum.chunk_every(3)
    |> Enum.map(fn rucksacks -> get_common_items(rucksacks) end)
    |> Enum.map(fn item -> Day3.get_item_priority(List.to_string(item)) end)
    |> Enum.sum()
  end

  defp get_common_items(rucksacks, repeated_items \\ [])

  defp get_common_items([[] | _], repeated_items) do
    repeated_items
  end

  defp get_common_items([[item | rucksack_1], rucksack_2, rucksack_3 | _], repeated_items) do
    if Enum.member?(rucksack_2, item) and Enum.member?(rucksack_3, item) do
      get_common_items([rucksack_1, rucksack_2, rucksack_3], [item | repeated_items])
    else
      get_common_items([rucksack_1, rucksack_2, rucksack_3], repeated_items)
    end
  end
end
