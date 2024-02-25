defmodule RangesOfSeed do


    def parse(file) do

      [seeds|maps] = String.split(File.read!(file),"\r\n\r\n") # Split the string by lines
      [_|seeds] = String.split(seeds," ") # Split the seeds by spaces
      seeds = Enum.map(seeds, fn x -> String.to_integer(x) end) # Convert the seeds to integers

      maps = Enum.map(maps, fn x -> String.split(x,"\n") end) # Split the maps by lines
      maps = Enum.map(maps, fn x -> Enum.map(x,fn y -> String.trim(y)end)end)
      maps = Enum.map(maps, fn [_|nums] -> nums;
      nums = Enum.map(nums, fn str_nums -> [dst, src, ran] = String.split(str_nums," "); {String.to_integer(dst), String.to_integer(src), String.to_integer(ran)} end);
      nums
     end)
# TRANSFORMATION ALGORITHM
def transformation(seeds, maps) do
  transformation(seeds, maps)
end

def transformation([], _), do: []
def transformation([seed | rest], maps) do
  [transform(seed, maps) | transformation(rest, maps)]
end

def transform(num, []), do: num
def transform(num, [{:map, trs} | rest]) do
  new_num = transf(num, trs)
  transform(new_num, rest)
end

def transf(num, []), do: num
def transf(num, [{:tr, to, from, length} | t]) do
  if num >= from and num <= (from + length - 1) do
    dif = num - from
    ret = to + dif
    ret # no further transf() because 'only 1 change per map'
  else
    transf(num, t)
  end
end

# MINIMUM VALUE
def minval([h | t]), do: minval(t, h, fn(x, acc) -> min(x, acc) end)
def minval([], acc, _), do: acc
def minval([h | t], acc, op), do: minval(t, op.(h, acc), op)
end
end

# Usage example
result = RangesOfSeed.parse("Seedfile.txt")

#transformed_values = RangesOfSeed.transform_all_seeds(seeds, maps)
IO.inspect(result)
