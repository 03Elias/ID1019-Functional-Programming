defmodule Springs22 do

  def parse_rows([]) do [] end
  def parse_rows([h | t]) do [ parse(h) | parse_rows(t)] end

  def parse(row) do
    row = String.trim(row)
    [springs, damaged_sizes] = String.split(row, " ")
    damaged_sizes = parse_damaged_sizes(damaged_sizes)
    springs = parse_springs(springs)
    springs = String.to_charlist(springs)
    {springs, damaged_sizes}

  end

  def parse_springs(str, multiplier) do
    Enum.reduce(1..multiplier, str, fn _, acc ->
      acc <> "?" <> str
    end)
  end

  def parse_damaged_sizes(str, multiplier) do
    sizes = String.split(str, ",")
            |> Enum.map(&Integer.parse(&1) |> elem(0))

    Enum.flat_map(1..multiplier, fn _ -> sizes end)
  end





 # def test do

   # sample = String.split(sample(), "\n")
    #sample = parse_rows(sample)
    #mem = Memory.new()
    #sample = springs(sample, mem)
    #total = sum(sample)

  #end

  def sum([]) do 0 end
  def sum([h | t]) do h + sum(t) end







  def springs([], _) do [] end
  def springs([h | t], mem) do
   # IO.inspect(h)
    [ check(h) | springs(t,mem)]
  end

  def check({chars, nums}) do
    {n, _} = check(chars, nums, Memory.new())
    n
  end

  def check(chars, nums, mem) do #chars = [char | t]
    #IO.puts("CHECK")
    case Memory.lookup({chars, nums}, mem) do
      nil ->
        #IO.puts("LOOKUP NOT FOUND #{inspect(chars)} #{inspect(nums)} #{inspect(mem)}")
        {answer, updated} = search(chars, nums, mem)
        #IO.puts("RETURN #{inspect(answer)} #{inspect(updated)} ")
        {answer, Memory.store({chars, nums}, answer, updated)}
      answer ->
        #IO.write("FOUND\n")
        {answer, mem}
    end
  end


  def search({chars, nums}, mem) do
   # IO.puts("START #{inspect(chars)} #{inspect(nums)} #{inspect(mem)}")
    search(chars, nums, mem)
  end

  def search([],[], mem) do
    #IO.puts("BASECASE #{inspect(mem)} ")
    {1, mem}
  end
  def search([], nums, mem) do {0, mem} end
  def search([chars | t], [], mem) do
   case chars do
      ?# -> {0, mem}
       _ -> search(t, [], mem)
    end
  end

  def search([char | t1],[num | t2], mem) do
    #IO.puts("MAINSEARCH #{inspect([char | t1])} #{inspect([num | t2])}, #{inspect(mem)}")
    case char do
      ?# ->
        case damaged(t1, num-1) do
          {:ok, rest} ->
            check(rest, t2, mem)
          :error ->
            {0, mem}
        end
      ?. ->
        check(t1, [num | t2], mem)
      ?? ->
      {answer, updated} = search([?. | t1], [num | t2], mem)
      {answer2, further} = search([?# | t1], [num | t2], updated)
      #IO.puts(" ANSWER MEM  #{inspect(answer)} + #{inspect(answer2)} #{inspect(further)} ")
      {answer + answer2, further}
    end
  end

  def damaged([], 0) do {:ok, []} end
  def damaged([nextchar | rest], 0) do
    if nextchar != ?# do
     {:ok, rest}
    else
      :error
    end
  end
  def damaged([?# | t], num) do damaged(t, num-1) end
  def damaged([?? | t], num) do damaged(t, num-1) end
  def damaged(_, num) do :error end

  def benchmark_multipliers(multipliers) do
    Enum.each(multipliers, fn multiplier ->
      # Prepare your data for the given multiplier
      # This is a placeholder - you'll need to adjust it to your actual data preparation logic
      input_data = "Your input data here" # Adjust this line to use real input data

      {time, _result} = :timer.tc(fn ->
        # Call your main function here with adjusted input for the current multiplier
        # For example, if `springs` is your main processing function:
        # springs(prepared_input_for_multiplier(multiplier), mem)
      end)

      IO.puts("Multiplier: #{multiplier}, Execution Time: #{time} microseconds")
    end)
  end


end
