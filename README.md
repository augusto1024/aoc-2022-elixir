# Advent of Code 2022 in Elixir

There's an `eval` function in the [AOC.Helpers](https://github.com/augusto1024/aoc-2022-elixir/blob/main/lib/helpers.ex) module to test the solutions with the given [inputs](https://github.com/augusto1024/aoc-2022-elixir/tree/main/inputs).


- Open an iex terminal
```bash
iex -S mix
```
- Run
```bash
AOC.Helpers.eval(&AOC.Day1.Puzzle1.get_elves_calories/1, "inputs/day1.txt")
```
