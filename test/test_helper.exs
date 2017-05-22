defmodule ListStore do
  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> [] end, name: @name)
  end

  def put(value) do
    Agent.update @name, fn state -> [value|state] end
  end

  def all do
    Agent.get(@name, fn state -> state end)
  end
end

ExUnit.start()
