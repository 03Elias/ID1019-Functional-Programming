defmodule EnvList do
  def new() do
    []
end

def add([],key,value) do [{key,value}] end
def add([{key,_}|map],key,value) do [{key,value}|map] end
def add([h|map],key,value) do [h|add(map,key,value)] end



def lookup([],_) do :nil end
def lookup([{key,value}|_],key) do {key,value} end
def lookup([_|map],key) do lookup(map,key) end

def remove([],_) do [] end
def remove([{key,_}|map],key) do map end
def remove([h|map],key) do [h|remove(map,key)] end
def remove_all(map,[]) do map end
def remove_all(map,[key|keys]) do

  map = remove(map,key)
remove_all(map,keys) end

end






 list = EnvList.new()
 list = EnvList.add(list,1,1)
 list = EnvList.add(list,3,6)
 list= EnvList.add(list, 3,3)
 list = EnvList.lookup(list,3)
  #list = EnvList.remove(list,3)
 IO.inspect(list)
