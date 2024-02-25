defmodule Eval do

  def eval({:mul,{:q,e1, e2},{:num, e2}},_) do e1 end
 def eval({:mul,{:num, e2}, {:q,e1,e2}},_) do {:num,e1} end
 def eval({:mul ,{:q, e1, e2}, {:num, e3}},_) when rem(e3,e2) == 0 do {:mul, {:div, {:num,e3},{:num,e2}},{:num,e1}} end
 def eval({:mul, {:q, e1,e2}, {:num, e3}},_) do {:q,e1*e3,e2} end



 def eval({:num, n}, _) do {:num,n} end
 def eval({:var, a}, map) do
  case EnvList.lookup(map,a) do
    {:q,b,c} ->  {:q,b,c}
    x -> {:num, x}
  end

end
 def eval({:add, e1, e2}, map) do add(eval(e1,map),eval(e2,map)) end
 def eval({:sub, e1,e2},map) do sub(eval(e1,map),eval(e2,map)) end
 def eval({:q, e1,e2},map) do {:q,eval(e1,map),eval(e2,map)}end
 def eval({:mul, e1, e2},map) do mul(eval(e1,map),eval(e2,map)) end



def add({:num,e1},{:num,e2}) do {:num, e1+e2} end
def sub({:num,e1},{:num,e2}) do {:num, e1-e2} end
def mul({:num, e1}, {:num,e2}) do {:num,e1*e2} end
def mul({:q,e1,e2}, {:num, e3}) do {:q, e1*e3,e2} end
def mul({:num, e3},{:q,e1,e2}) do {:q, e1*e3,e2} end
# eval({:mul, eval(e1,map),eval(e2,map)},map


end
myList = EnvList.new()
myList = EnvList.add(myList, :x, {:q, 3, 2})

#myList = EnvList.add(myList, :x, {:q, 5,2})
IO.inspect(Eval.eval({:mul, {:var, :x}, {:num, 4}}, myList))
