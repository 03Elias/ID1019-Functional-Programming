
defmodule Test do
def eval({:var, x}, mymap) do Map.get(mymap, x) end

end

IO.inspect(Test.eval(x))
