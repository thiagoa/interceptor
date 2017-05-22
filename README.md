# Interceptor

This basic module is able to intercept return values of function calls by means
of a custom callback.

```elixir
defmodule StdoutLogger do
  def log(value) do
    IO.puts "Method called with #{value}!"
  end
end

defmodule Calculator do
  use Interceptor, callback: &StdoutLogger.log/1

  def sum(a, b), do: a + b
end
```

Currently, it has some limitations: if you define methods from within a macro,
`Interceptor` is not able to act on them. I'm still figuring out how to do
that.

This is just an exploration of Macros, and not something to be used in
production.  There are appropriate tools for tracing already.
