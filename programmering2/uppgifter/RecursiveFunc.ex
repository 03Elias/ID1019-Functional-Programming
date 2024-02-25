defmodule Recursivfunc do

 def lengthh([]) do 0 end
 def lengthh([_|map]) do 1 + length(map) end

 def even([]) do [] end
 def even([x|map]) do
  if rem(x,2) == 0 do
    [x|even(map)]
  else
    even(map)
  end
 end

 def inc([]) do [] end
 def inc([x|map]) do [x+1|inc(map)] end

 def sum([]) do 0 end
 def sum([x|map]) do x + sum(map) end

 def dec([]) do [] end
 def dec([x|map]) do [x-1|dec(map)] end

 def mul([],_) do [] end
 def mul([x|map],n) do [x*n |mul(map,n)] end

 def odd([]) do []end
 def odd([x|map]) do
  if rem(x,2) == 1 do
    [x|odd(map)]
  else
    odd(map)
  end
 end

def remm([],_) do [] end
def remm([x|map],n) do
  [rem(x,n)|remm(map,n)]
end

def prod([]) do 1 end
def prod([x|map]) do x * prod(map) end

def divv([],_) do [] end
def divv([x|map],n) do
if rem(x,n) == 0 do
  [x|divv(map,n)]
else
  divv(map,n)
end

 end

 ##### Higher Order Functions #####

def mapp([],_) do [] end
def mapp([x|map],f) do [f.(x)|mapp(map,f)] end

def reducel([], b, _) do b end
def reducel([x|map], b, func) do
  reducel(map, func.(x, b), func) ## vänster till höger Left to Right
end

def reducer([],b,_) do b end
def reducer([x|map],b,func) do
  func.(x,reducer(map,b,func)) #Right to Left, höger till vänster
end

#### Filter ####
def filter([],_) do [] end
def filter([x|map],func) do
  if func.(x) do
    [x|filter(map,func)]
  else
    filter(map,func)
  end
end


def filter2(list, func) do
  filter2_tail(list, func, [])
end

def filter2_tail([], _, acc) do
  Enum.reverse(acc)
end

def filter2_tail([x | map], func, acc) do
  if func.(x) do
    filter2_tail(map, func, [x | acc])
  else
    filter2_tail(map, func, acc)
  end
end



def filter_rev(list,func) do
  filter_rev(list,func,[])
end
def filter_rev([],_,acc) do
  acc
end
def filter_rev([x|map],func,acc) do
  if func.(x) do
    filter_rev(map,func,[x|acc])
  else
    filter_rev(map,func,acc)
  end
end
##### Reimplementation of the old functions with higher order functions ####
def lengthh2(list) do
  reduce(list, 0, fn(x, acc) -> acc + 1 end)
end

def even2(list) do
  filter(list, fn(x) -> rem(x, 2) == 0 end)
end

def inc2(list) do
  mapp(list, fn(x) -> x + 1 end)
end

def sum2(list) do
  reduce(list, 0, fn(x, acc) -> x + acc end)
end

def dec2(list) do
  mapp(list, fn(x) -> x - 1 end)
end

def mul2(list, n) do
  mapp(list, fn(x) -> x * n end)
end

def odd2(list) do
  filter(list, fn(x) -> rem(x, 2) == 1 end)
end

def remm2(list, n) do
  mapp(list, fn(x) -> rem(x, n) end)
end

def prod2(list) do
  reduce(list, 1, fn(x, acc) -> x * acc end)
end

def divv2(list, n) do
  filter(list, fn(x) -> rem(x, n) == 0 end)
end

def squareSum(list) do
  reduce(list, 0, fn(x, acc) -> x * x + acc end)
end


 end



 list = [1, 2, 3]
 func = fn(x) -> x > 1 end
 filtered_list = Recursivfunc.filter_rev(list,func)
 IO.inspect(filtered_list)
