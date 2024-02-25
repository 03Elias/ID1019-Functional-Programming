defmodule Chopstick do
  def start do
    spawn_link(fn -> loop(:available) end)
  end

  defp loop(:available) do
    receive do
      {:request, from} ->
        send(from, :granted)
        loop(:gone)
      :quit ->
        :ok
    end
  end

  defp loop(:gone) do
    receive do
      :return ->
        loop(:available)
      :quit ->
        :ok
    end
  end

  def request(stick) do
    send(stick, {:request, self()})
    receive do
      :granted -> :ok
    end
  end

  def return(stick) do
    send(stick, :return)
  end

  def quit(stick) do
    send(stick, :quit)
  end

end
