defmodule EnvTree do

  def new() do nil end

def add(nil, key, value) do

{:node,key,value,nil,nil}

end

def add({:node, key, _, left, right}, key, value) do
  {:node, key, value, left, right}
  end

  def add({:node, k, v, left, right}, key, value) when key < k do
 {:node,k, v,add(left,key,value), right} #Rekursiv och skriva add(left,key,value)
    # ... return a tree that looks like the one we have
    #but where the left branch has been updated ...
    end

    def add({:node, k, v, left, right}, key, value) do

     {:node, k, v, left, add(right,key,value)}

      #... same thing but instead update the right banch right add(right,key,value)
      end

  def lookup(nil, _) do nil end
  def lookup({:node,key,v,left,right},key) do {key,v} end
  def lookup({:node,k,v,left,right},key) when key < k do lookup(left,key) end
  def lookup({:node,k,v,left,right},key) when key > k do lookup(right,key) end

  def remove(nil,_) do nil end
  def remove({:node, key, _, nil, right}, key) do right end
  def remove({:node, key, _, left, nil}, key) do left end

  def remove({:node, key, _, left, right}, key) do
    {newKey,newValue,rest} = leftmost(right)
    {:node, newKey, newValue, left, rest}
    end

    def remove({:node, k, v, left, right}, key) when key < k do
      {:node, k, v, remove(left,key), right}
      end

  def remove({:node, k, v, left, right}, key) do
    {:node, k, v, left, remove(right,key)}
    end


  def leftmost({:node, key, value, nil, rest}) do {key, value, rest} end
  def leftmost({:node, k, v, left, right}) do
    {key, value, rest} = leftmost(left)
    {key, value, {:node,k,v,rest,right}}
    end

end



 tree = EnvTree.new()
 tree = EnvTree.add(tree, 10, "Ten")
  tree = EnvTree.add(tree, 5, "Five")
  tree = EnvTree.add(tree, 15, "Fifteen")
  tree = EnvTree.add(tree, 6, "Six")
  tree = EnvTree.add(tree, 16, "Sixteen")
#  mylookup = EnvTree.lookup(tree,16)
#  myleftmost = EnvTree.leftmost(tree)
#  myremove = EnvTree.remove(tree,15)
IO.puts"Tree"
IO.inspect(tree)
# IO.puts"lookup"
# IO.inspect(mylookup)
# IO.puts"leftmost"
# IO.inspect(myleftmost)
# IO.puts"remove"
# IO.inspect(myremove)
