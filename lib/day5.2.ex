defmodule AOC.Day5.Puzzle2 do
  alias AOC.Day5.Puzzle1, as: Day5

  def get_top_crates(plan) do
    stacks = Day5.get_stacks(plan)
    movements = Day5.get_movements(plan)

    movements
    |> Enum.reduce(
      stacks,
      fn [amount, from, to], stacks ->
        {crates, rest_from_stack} = Enum.split(Enum.at(stacks, from - 1), amount)

        stacks
        |> List.replace_at(to - 1, Enum.concat(crates, Enum.at(stacks, to - 1)))
        |> List.replace_at(from - 1, rest_from_stack)
      end
    )
    |> Enum.map(fn stack -> List.first(stack) end)
    |> Enum.join()
  end
end
