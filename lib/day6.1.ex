defmodule AOC.Day6.Puzzle1 do
  def get_start_of_packet_index(message) do
    message
    |> String.trim()
    |> String.to_charlist()
    |> find_marker(4)
  end

  def find_marker(
        [x | rest_of_message] = message,
        marker_length,
        marker \\ [],
        message_start_index \\ 0
      ) do
    if Enum.count(marker) != marker_length do
      with nil <- Enum.find_index(marker, fn elem -> elem == x end) do
        find_marker(rest_of_message, marker_length, marker ++ [x], message_start_index + 1)
      else
        index ->
          find_marker(message, marker_length, Enum.drop(marker, index + 1), message_start_index)
      end
    else
      message_start_index
    end
  end
end
