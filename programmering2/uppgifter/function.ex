foo = fn x -> x + 2 end
IO.puts foo.(23)
bar = foo
IO.puts bar.(23)
IO.puts "bar == foo is #{bar==foo}"
zot = fn x -> x + 2 end
defmodule Test do
  def plus2 (x) do
   x + 2
  end
  def to_farenhit(c) do
    c * 1.8 + 32
  end
end
IO.puts Test.plus2(25)
IO.puts Test.to_farenhit(0)

# Rekursiva program
defmodule Rekursiv do
def prod(a,b) do
if a == 0 do
0
else
prod(a-1,b) + b
end
end
end
IO.puts "Produkten blir #{Rekursiv.prod(3,3)}"

defmodule Rekursiv2 do
  def fib(n) do
    case n do
      0 -> 0
      1 -> 1
      _ -> fib(n-1) + fib(n-2)
    end
  end
end
IO.puts "fiboachi talet blir #{Rekursiv2.fib(40)}"

#Tuples
defmodule Tuples do

  def sum(x) do
  case x do
    {} -> 0
    {a} -> a

  end
  end
