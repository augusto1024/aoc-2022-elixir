defmodule AOC.Day2.Puzzle1 do
  def get_total_score(strategy) do
    strategy
    |> String.trim()
    |> String.split(~r/\n/)
    |> Enum.map(&String.split(&1, ~r/\s/))
    |> Enum.map(&calculate_round_score/1)
    |> Enum.sum()
  end

  defp calculate_round_score([_, "X"] = picks),
    do: 1 + calculate_round_result_score(picks)

  defp calculate_round_score([_, "Y"] = picks),
    do: 2 + calculate_round_result_score(picks)

  defp calculate_round_score([_, "Z"] = picks),
    do: 3 + calculate_round_result_score(picks)

  defp calculate_round_result_score(picks) do
    case picks do
      ["A", "Y"] -> 6
      ["B", "Z"] -> 6
      ["C", "X"] -> 6
      ["A", "X"] -> 3
      ["B", "Y"] -> 3
      ["C", "Z"] -> 3
      _ -> 0
    end
  end
end
