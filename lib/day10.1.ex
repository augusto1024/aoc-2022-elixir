defmodule AOC.Day10.Puzzle1 do
  def get_signal_strengths_sum(program) do
    program
    |> String.trim()
    |> String.split(~r/\n/)
    |> execute_program(&update_signal_strengths/3)
    |> Enum.map(fn {cycle, x} -> cycle * x end)
    |> Enum.sum()
  end

  def execute_program(
        program,
        x \\ 1,
        cycle \\ 0,
        execution_callback,
        args \\ []
      )

  def execute_program([], _x, _cycle, _, args) do
    args
  end

  def execute_program([instruction | rest_of_program], x, cycle, execution_callback, args) do
    {current_x, current_cycle, new_args} =
      execute(instruction, x, cycle, execution_callback, args)

    execute_program(rest_of_program, current_x, current_cycle, execution_callback, new_args)
  end

  defp execute(instruction, x, current_cycle, execution_callback, args, cycle_count \\ 1)

  defp execute("addx " <> number, x, current_cycle, execution_callback, args, 0) do
    new_x = x + String.to_integer(number)
    new_cycle = current_cycle + 1
    new_args = execution_callback.(args, new_cycle, x)
    {new_x, new_cycle, new_args}
  end

  defp execute(
         "addx " <> _ = instruction,
         x,
         current_cycle,
         execution_callback,
         args,
         cycle_count
       ) do
    new_cycle = current_cycle + 1
    new_args = execution_callback.(args, new_cycle, x)
    execute(instruction, x, new_cycle, execution_callback, new_args, cycle_count - 1)
  end

  defp execute("noop", x, current_cycle, execution_callback, args, _) do
    new_cycle = current_cycle + 1
    new_args = execution_callback.(args, new_cycle, x)
    {x, new_cycle, new_args}
  end

  defp update_signal_strengths(signal_strengths, cycle, x) do
    if Enum.member?([20, 60, 100, 140, 180, 220], cycle) do
      [{cycle, x} | signal_strengths]
    else
      signal_strengths
    end
  end
end
