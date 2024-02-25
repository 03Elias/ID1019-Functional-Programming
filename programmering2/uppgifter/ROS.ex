defmodule Ros do

  defmodule PuzzleParser do
    def parse_input(input) do
      [seeds_string | maps_strings] = String.split(input, "\n\n")
      seeds = parse_seeds(seeds_string)
      maps = Enum.map(maps_strings, &parse_map/1)
      {seeds, maps}
    end

    defp parse_seeds(seeds_string) do
      seeds_string
      |> String.split(" ")
      |> Enum.filter_map(fn str -> str =~ /^\d+$/ end, fn str ->
        case Integer.parse(str) do
          {num, _} -> {:ok, num}
          :error -> {:error, str}
        end
      end)
    end

    defp parse_map(map_string) do
      map_string
      |> String.split("\n")
      |> Enum.map(fn line ->
        [dest, source, range] = String.split(line, " ")
        {Integer.parse(dest) |> elem(0), Integer.parse(source) |> elem(0), Integer.parse(range) |> elem(0)}
      end)
    end
  end
  defmodule Transformer do
    def apply_transformations(seeds, maps) do
      Enum.reduce(maps, seeds, fn map, acc ->
        Enum.map(acc, fn seed -> apply_map(seed, map) end)
      end)
    end

    defp apply_map(seed, map) do
      Enum.reduce(map, seed, fn {dest, source, range}, acc ->
        if acc >= source and acc <= source + range - 1, do: dest + (acc - source), else: acc
      end)
    end
  end
  defmodule PuzzleSolver do
    def solve(input) do
      {seeds, maps} = PuzzleParser.parse_input(input)
      final_locations = Transformer.apply_transformations(seeds, maps)
      Enum.min(final_locations)
    end
  end

end
lowest_location = Ros.PuzzleSolver.solve("Seedfile.txt")

IO.puts("Lowest Location Number: #{lowest_location}")
