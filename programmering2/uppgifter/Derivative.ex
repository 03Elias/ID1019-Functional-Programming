defmodule Derivative do





  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, var}, var) do {:var, 1} end
  def deriv({:var, _}, _) do {:var, 0} end # other variables count as constants.




  def deriv({:add, e1, e2}, var) do
    {:add, deriv(e1, var), deriv(e2, var)}
  end


  def deriv({:exp, e, {:num, n}}, v) do {:mul, {:mul, {:num, n}, {:exp, e, {:num, n-1}}}, deriv(e,v)} end

  def deriv({:sin, e}, v) do {:mul, {:cos, e}, deriv(e,v)} end

  def deriv({:cos, e}, v) do {:mul, {:mul, {:sin, e}, {:num, -1}}, deriv(e,v)} end

  def deriv({:div, e1, e2},v) do {:div, {:sub, {:mul, deriv(e1,v), e2}, {:mul, deriv(e2,v), e1} }, {:mul, e2, e2}} end

  #def deriv({:mul, {:var, e1}, {:var, e2}},v) do {:add, {:mul, deriv(e1,v), e2}, {:mul, deriv(e2,v), e1}} end

  def deriv({:ln, e},v) do {:mul,{:div, {:num, 1}, e}, deriv(e,v)} end

  def deriv({:mul, e1, e2}, var) do {:add, {:mul, deriv(e1, var), e2}, {:mul, e1, deriv(e2, var)}} end

  def simplify({:add, {:var, 1}, {:var, 0}}) do {:var, 1} end
  def simplify({:add, {:var, 0}, {:var, 1}}) do {:var, 1} end
  def simplify({:mul, {:num, num}, {:var, 1}}) do {:num, num} end
  def simplify({:mul, {:var, 1}, {:num, num}}) do {:num, num} end
  def simplify({:add, e1, e2}) do simplify_add(simplify(e1), simplify(e2)) end
  def simplify({:mul, e1, e2}) do simplify_mul(simplify(e1), simplify(e2)) end
  def simplify({:exp, e1, e2}) do simplify_exp(simplify(e1), simplify(e2)) end
  def simplify(e) do e end

  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
  def simplify_add({:num, 0}, e2) do e2 end
  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add(e1, e2) do {:add, e1, e2} end


  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1 * n2} end
  def simplify_mul({:num, e1}, {:mul, {:num, e2}, e3}) do simplify_mul({:num, e1*e2},e3) end
  def simplify_mul({:mul, {:num, e2}, e3}, {:num, e1}) do simplify_mul({:num, e1*e2},e3) end
  def simplify_mul({:mul, {:sin,{:mul,e1,e2}},{:sin,{:mul,e1,e2}}}) when e1==e2 do {:exp, {:sin,{:mul,e1,e2}}, {:num, 2}} end
  def simplify_mul(e1,e2) when e1 == e2 do {:exp, e1, {:num, 2}} end
  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_exp(_,{:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp(e1, e2) do {:exp, e1, e2} end

  def pprint({:exp, e1,e2}) do "(#{pprint(e1)} ^ (#{pprint (e2)}))" end
  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1,e2}) do "(#{pprint(e1)} + #{pprint (e2)})" end
  def pprint({:mul, e1,e2}) do "(#{pprint(e1)} * #{pprint (e2)})" end
  def pprint({:sin, e1}) do "sin(#{pprint(e1)})" end
  def pprint({:cos, e1}) do "cos(#{pprint(e1)})" end
  def pprint({:div, e1, e2}) do "#{pprint(e1)} / #{pprint(e2)}" end
  def pprint({:sub, e1, e2}) do "#{pprint(e1)} - #{pprint(e2)}" end
  def pprint({:ln, e}) do "ln (#{pprint(e)})" end
end

#e = {:add, {:var, :x}, {:var, :y}}
e = {:add,{:exp, {:mul, {:num, 8}, {:var, :x}}, {:num, 2}}, {:num, 3}}
#e = {:div, {:add, {:var, :x}, {:num, 2}, {:var, :x}}}
#e = {:sin, {:mul, {:num, 2}, {:var, :x}}}
#e = {:exp, {:var, :x}, {:num, 0.5}}
#e = {:mul, {:add, {:var, :x}, {:num, 2}}, {:var, :x}}
#e = {:div, {:num, 1}, {:sin, {:mul, {:var, :x}, {:num, 2}}}}
#e = {:ln, {:var,:x}}



IO.puts "The pretty print input is: #{Derivative.pprint(e)}"
IO.puts "The pretty print output is: #{Derivative.pprint(Derivative.deriv(e, :x))}"
IO.puts "The derivative is: #{inspect(Derivative.deriv(e, :x))}" #print out test subject
IO.puts "Simplified is: #{Derivative.pprint(Derivative.simplify(Derivative.deriv(e, :x)))}"
