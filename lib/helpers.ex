defmodule AOC.Helpers do
  def eval(fun, file) do
    with {:ok, input} <- File.read(file) do
      fun.(input)
    else
      _ -> raise "File doesn't exist"
    end
  end
end
