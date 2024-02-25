defmodule Springs do

def parse(file) do
  String.split(File.read!(file),"\r\n")#Split the string
  |>
   Enum.map(fn x -> String.split(x," ") end) #Split the hashtags, question marks, and the on left side and right numbers.
  |>
  Enum.map(fn x -> {String.to_charlist(Enum.at(x,0)),Enum.map(String.split(Enum.at(x,1), ","), fn y -> String.to_integer(y)end)} end)


end
def solve([]) do [] end
def solve([h|map]) do
  [search(h)|solve(map)]
end
def search({char,number}) do search(char,number) end
def search([],[]) do 1 end
def search([], number) do 0 end
def search([char|map1],[]) do
case char do
  ?# -> 0
  _ -> search(map1, [])
end
end

def search([char|map1], [number|map2]) do
  case char do
    ?. -> search(map1, [number|map2])
    ?# -> case damage(map1,number-1) do
      :error -> 0
      {:ok, rest} -> search(rest,map2)

    end
    ?? -> search([?#|map1],[number|map2]) + search([?.|map1],[number|map2])
    end


  end

def damage([],0) do {:ok, []} end
def damage([char|restOfCharlist],0) do
  if char != ?# do
    {:ok, restOfCharlist}
  else
    :error

  end
end
def damage([?#|map1],number) do
damage(map1,number-1)
end
def damage([??|map1],number) do
  damage(map1,number-1)
  end
  def damage(_,number) do
    :error
    end



    


  end
  test = Springs.parse("file.txt")
  #test = Springs.solve(test)
  IO.inspect(test)
