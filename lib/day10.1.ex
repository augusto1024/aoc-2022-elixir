defmodule AOC.Day10.Puzzle1 do
  def get_signal_strengths_sum(program) do
    program
    |> String.trim()
    |> String.split(~r/\n/)
    |> execute_program()
    |> Enum.map(fn {cycle, x} -> cycle * x end)
    |> Enum.sum()
  end

  defp execute_program(program, x \\ 1, cycle \\ 0, signal_strengths \\ [])

  defp execute_program([], _x, _cycle, signal_strengths) do
    signal_strengths
  end

  defp execute_program([instruction | rest_of_program], x, cycle, signal_strengths) do
    {current_x, current_cycle, signal_strengths} =
      execute(instruction, x, cycle, signal_strengths)

    execute_program(rest_of_program, current_x, current_cycle, signal_strengths)
  end

  defp execute(instruction, x, current_cycle, signal_strengths, cycle_count \\ 1)

  defp execute("addx " <> number, x, current_cycle, signal_strengths, 0) do
    new_x = x + String.to_integer(number)
    new_cycle = current_cycle + 1
    new_signal_strengths = update_signal_strengths(signal_strengths, new_cycle, x)
    {new_x, new_cycle, new_signal_strengths}
  end

  defp execute("addx " <> _ = instruction, x, current_cycle, signal_strengths, cycle_count) do
    new_cycle = current_cycle + 1
    new_signal_strengths = update_signal_strengths(signal_strengths, new_cycle, x)
    execute(instruction, x, new_cycle, new_signal_strengths, cycle_count - 1)
  end

  defp execute("noop", x, current_cycle, signal_strengths, _) do
    new_cycle = current_cycle + 1
    new_signal_strengths = update_signal_strengths(signal_strengths, new_cycle, x)
    {x, new_cycle, new_signal_strengths}
  end

  defp update_signal_strengths(signal_strengths, cycle, x) do
    if Enum.member?([20, 60, 100, 140, 180, 220], cycle) do
      [{cycle, x} | signal_strengths]
    else
      signal_strengths
    end
  end
end
