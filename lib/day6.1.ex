defmodule AOC.Day6.Puzzle1 do
  def get_start_of_packet_index(message) do
    message
    |> String.trim()
    |> String.to_charlist()
    |> find_marker()
  end

  def find_marker([x | rest_of_message] = message, marker \\ [], message_start_index \\ 0) do
    if Enum.count(marker) != 4 do
      with nil <- Enum.find_index(marker, fn elem -> elem == x end) do
        find_marker(rest_of_message, marker ++ [x], message_start_index + 1)
      else
        index -> find_marker(message, Enum.drop(marker, index + 1), message_start_index)
      end
    else
      message_start_index
    end
  end
end
