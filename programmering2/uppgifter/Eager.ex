defmodule Eager do
  def eval_expr({:atm, id}, ...) do
    {:ok, id}
  end

  def eval_expr({:var, id}, env) do
    case EnvList.lookup(env, id) do
      nil -> :error
      {_, str} -> {:ok, str}
    end
  end

  def eval_expr({:cons, expression1, expression2}, env) do
    case eval_expr(expression1, env) do
      :error ->
        :error

      {:ok, value1} ->
        case eval_expr(expression2, env) do
          :error ->
            :error

          {:ok, value2} ->
            {:ok, {value1, value2}}
        end
    end
  end

  def eval_match({:atm, _}, _, env) do
    {:ok, env}
  end

  def eval_match({:var, :x}, :a, env) do
    {:ok, EnvList.add(env, :x, :a)}
  end

  # def eval_match({:var,:x}, :a, env) do {:ok, env } end  # Line abow catches all cases.
  def eval_match({:var, x}, a, env) do
    case EnvList.lookup(env, x) do
      nil -> {:ok, EnvList.add(env, x, a)}
      {_, ^a} -> {:ok, env}
      {_, _} -> :fail
    end
  end

  def eval_match({:cons, exp1, exp2}, {value1, value2}, env) do
    case eval_match(exp1, value1, env) do
      :fail -> :fail
      {:ok, env} ->  eval_match(exp2, value2, env)

    end
  end
  def eval_match(_, _, _) do
    :fail
    end

  def eval_match(:ignore, _, env) do
    {:ok, env}
    end

    def eval_match({:atm, _}, _, env) do
    {:ok, env}
    end

    def extract_vars(pattern) do extract_vars(pattern, []) end
    def extract_vars({:var, var},list) do [var|list] end
    def extract_vars({:atm, _}, list) do list end
    def extract_vars({:cons,v,w},list) do
      list = extract_vars(v,list)
      list = extract_vars(w,list)
     end
     def extract_vars(:ignore,list) do list end

     def eval_scope(pattern, env) do
      EnvList.remove_all(env, extract_vars(pattern))
      end

      def eval_seq([exp], env) do
        eval_expr(exp, env)
        end
        def eval_seq([{:match, p, exp} | rest], env) do
          case eval_expr(exp, env) do
          :error ->
          :error
          {:ok, value} ->
          env = eval_scope(p, env)
          end
        end
end
IO.inspect(Eager.eval_match({:cons, {:var, :x}, {:var, :y}}, {:a, :b}, []))
