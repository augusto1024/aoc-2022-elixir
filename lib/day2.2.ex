defmodule AOC.Day2.Puzzle2 do
  def get_total_score(strategy) do
    strategy
    |> String.trim()
    |> String.split(~r/\n/)
    |> Enum.map(&String.split(&1, ~r/\s/))
    |> Enum.map(&calculate_round_score/1)
    |> Enum.sum()
  end

  def calculate_round_score(picks) do
    case picks do
      ["A", "Y"] -> 3 + calculate_round_pick_score("A")
      ["B", "Y"] -> 3 + calculate_round_pick_score("B")
      ["C", "Y"] -> 3 + calculate_round_pick_score("C")
      ["A", "Z"] -> 6 + calculate_round_pick_score("B")
      ["B", "Z"] -> 6 + calculate_round_pick_score("C")
      ["C", "Z"] -> 6 + calculate_round_pick_score("A")
      ["A", "X"] -> 0 + calculate_round_pick_score("C")
      ["B", "X"] -> 0 + calculate_round_pick_score("A")
      ["C", "X"] -> 0 + calculate_round_pick_score("B")
    end
  end

  defp calculate_round_pick_score(pick) do
    case pick do
      "A" -> 1
      "B" -> 2
      "C" -> 3
    end
  end
end
