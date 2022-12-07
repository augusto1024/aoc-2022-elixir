defmodule AOC.Day5.Puzzle1 do
  def get_top_crates(plan) do
    stacks = get_stacks(plan)
    movements = get_movements(plan)

    movements
    |> Enum.reduce(
      stacks,
      fn [amount, from, to], stacks ->
        Enum.reduce(1..amount, stacks, fn _, stacks ->
          [crate | rest_from_stack] = Enum.at(stacks, from - 1)

          stacks
          |> List.replace_at(to - 1, [crate | Enum.at(stacks, to - 1)])
          |> List.replace_at(from - 1, rest_from_stack)
        end)
      end
    )
    |> Enum.map(fn stack -> List.first(stack) end)
    |> Enum.join()
  end

  def get_stacks(plan) do
    plan
    |> String.split(~r/\n/)
    |> Enum.take_while(fn line -> Regex.match?(~r/^ \d/, line) == false end)
    |> Enum.map(fn line ->
      Regex.scan(~r/ {4}|(?<=\[)\w(?=\])/, line)
      |> List.flatten()
    end)
    |> Enum.zip()
    |> Enum.map(fn stack ->
      stack
      |> Tuple.to_list()
      |> Enum.filter(fn elem -> Regex.match?(~r/\w/, elem) end)
    end)
  end

  def get_movements(plan) do
    plan
    |> String.split(~r/\n/)
    |> Enum.map(fn line ->
      Regex.scan(~r/move (\d+).*(\d+).*(\d+)/, line, capture: :all_but_first)
      |> List.flatten()
    end)
    |> Enum.filter(fn line -> Enum.count(line) > 0 end)
    |> Enum.map(fn movement ->
      Enum.map(movement, fn num -> String.to_integer(num) end)
    end)
  end
end
