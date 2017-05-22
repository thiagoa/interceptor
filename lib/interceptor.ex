defmodule Interceptor do
  defmacro __using__(opts) do
    quote do
      import Kernel, except: [def: 2]
      import Interceptor

      @interceptor unquote(opts[:callback])
      @functions Tuple.to_list(unquote(opts[:only]) || {})
    end
  end

  defmacro def(def, do: block) do
    quote do
      Kernel.def unquote(def) do
        fn -> unquote(block) end.()
        |> intercept(unquote(def))
      end
    end
  end

  defmacro intercept(value, def) do
    quote do
      if intercept?(unquote(def)) do
        unquote(value) |> @interceptor.()
      end

      unquote(value)
    end
  end

  defmacro intercept?(def) do
    {name, _, _} = def

    quote do
      Enum.empty?(@functions) || Enum.member?(@functions, unquote(name))
    end
  end
end
