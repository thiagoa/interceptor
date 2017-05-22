  defmodule Conc do
    def sum(a, b), do: a + b
    def concat(left, right), do: left <> right
  end

  defmodule Other do
    import List, only: [to_tuple: 1]

    IO.inspect to_tuple([1,2])
  end

  defmodule Main do
    def exec do
    end
  end

  Main.exec
