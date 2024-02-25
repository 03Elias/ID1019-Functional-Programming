defmodule Springs2 do
  # Reads the input from a file and parses it into a list of {description, numbers} tuples
  def parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      [desc, nums] = String.split(x, " ")
      {
        String.graphemes(desc),
        String.split(nums, ",", trim: true)
        |> Enum.map(&String.trim/1) # Trim each number string
        |> Enum.map(&String.to_integer/1) # Convert to integer after trimming
      }
    end)
  end

  # Extends the row description n times with '?' in between each repetition
  def extend_row(description, numbers, n) do
    extended_description =
      1..n
      |> Enum.reduce(description, fn _, acc -> acc ++ ["?"] ++ description end)

    extended_numbers = List.duplicate(numbers, n) |> List.flatten()
    {extended_description, extended_numbers}
  end

  # Processes and solves all puzzles, extending each row n times and includes benchmarking
  def process_and_solve(file, n_times) do
    puzzles = parse(file)

    results = 1..n_times
    |> Enum.map(fn multiplier ->
      {time, result} = :timer.tc(fn ->
        puzzles
        |> Enum.map(&extend_row(elem(&1, 0), elem(&1, 1), multiplier))
        |> Enum.map(&solve/1)
      end)

      time_in_seconds = time / 1_000_000
      IO.puts("Multiplier: #{multiplier}, Time: #{time_in_seconds} seconds")
      {multiplier, result}  # Return the results along with the multiplier for inspection
    end)

    results
  end

  # Placeholder solve function, replace with actual solving logic
  def solve({description, numbers}) do
    solve(description, numbers, %{}, "")
  end

  # Dynamic programming approach to solving a puzzle
  defp solve([], [], memory, key), do: Map.get(memory, key, 1)
  defp solve(_, _, memory, key) when is_map_key(memory, key), do: memory[key]
  defp solve(description, numbers, memory, key) do
    new_key = Enum.join(description) <> Enum.join(numbers, ",")
    memory = Map.put(memory, new_key, 1) # Placeholder result, adjust as needed
    {1, memory} # Return a placeholder result and updated memory
  end
end

# To run the process and see both execution times and results
#results = Springs2.parse("file2.txt")
results = Springs2.process_and_solve("file2.txt" , 10)
IO.inspect(results, label: "Results")
