defmodule Chopstick1 do
  def start do
    IO.puts("Starting chopstick process")
    spawn_link(fn -> loop(:available) end)
  end

  defp loop(:available) do
    IO.puts("Chopstick is available")
    receive do
      {:request, from} ->
        IO.puts("Chopstick requested by #{inspect(from)}")
        send(from, :granted)
        loop(:gone)
      :quit -> :ok
    end
  end

  defp loop(:gone) do
    IO.puts("Chopstick is gone")
    receive do
      :return ->
        IO.puts("Chopstick returned")
        loop(:available)
      :quit -> :ok
    end
  end

  def request(stick) do
    send(stick, {:request, self()})
    receive do
      :granted -> IO.puts("Chopstick granted")
    end
  end

  def return(stick) do
    IO.puts("Returning chopstick")
    send(stick, :return)
  end

  def quit(stick) do
    IO.puts("Terminating chopstick process")
    send(stick, :quit)
  end
end
pid = Chopstick1.start()
Chopstick1.request(pid)
Chopstick1.return(pid)
Chopstick1.quit(pid)
