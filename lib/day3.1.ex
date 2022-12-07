defmodule AOC.Day3.Puzzle1 do
  def get_priority_sum(rucksacks) do
    rucksacks
    |> String.trim()
    |> String.split(~r/\n/)
    |> Enum.map(
      &(&1
        |> String.to_charlist()
        |> Enum.split(round(String.length(&1) / 2))
        |> get_repeated_items)
    )
    |> Enum.map(&get_item_priority(List.to_string(&1)))
    |> Enum.sum()
  end

  defp get_repeated_items({left_rucksack, right_rucksack}) do
    do_get_repeated_items(Enum.uniq(left_rucksack), Enum.uniq(right_rucksack), [])
  end

  defp do_get_repeated_items([], _, repeated_items) do
    repeated_items
  end

  defp do_get_repeated_items(
         [left_item | rest_of_left_rucksack],
         right_rucksack,
         repeated_items
       ) do
    if Enum.member?(right_rucksack, left_item) do
      do_get_repeated_items(rest_of_left_rucksack, right_rucksack, [left_item | repeated_items])
    else
      do_get_repeated_items(rest_of_left_rucksack, right_rucksack, repeated_items)
    end
  end

  def get_item_priority(item) do
    ascii_value = :binary.first(item)

    if ascii_value <= 90 do
      ascii_value - 38
    else
      ascii_value - 96
    end
  end
end
