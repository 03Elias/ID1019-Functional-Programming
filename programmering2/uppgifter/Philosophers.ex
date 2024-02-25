defmodule Philosopher do
  def start(hunger, left, right, name, ctrl) do
    spawn_link(fn -> loop(hunger, left, right, name, ctrl) end)
  end

  defp loop(0, _left, _right, name, ctrl) do
    send(ctrl, {:done, name})
    IO.puts("#{name} is done eating and now forever dreaming.")
  end

  defp loop(hunger, left, right, name, ctrl) do
    dream()
    IO.puts("#{name} is trying to eat.")
    Chopstick.request(left)
    IO.puts("#{name} received left chopstick.")
    Chopstick.request(right)
    IO.puts("#{name} received right chopstick.")
    eat()
    Chopstick.return(left)
    Chopstick.return(right)
    IO.puts("#{name} has finished eating.")
    loop(hunger - 1, left, right, name, ctrl)
  end

  defp dream do
    :timer.sleep(:rand.uniform(0))  # Dream for up to 1000 milliseconds
  end

  defp eat do
    :timer.sleep(:rand.uniform(0))  # Eat for up to 1000 milliseconds
  end
end
