defmodule InterceptorTest do
  use ExUnit.Case
    
  defmodule Logger do
    def call(value) do
      case value do
        value when is_integer(value) -> ListStore.put "Integer: #{value}"
        value -> ListStore.put "Other: #{value}"
      end
    end
  end

  setup do
    {:ok, pid: ListStore.start_link}
  end

  defmodule InterceptAll do
    use Interceptor, callback: &Logger.call/1

    def sum(a, b), do: a + b
    def concat(left, right), do: left <> right
  end

  test "intercepts function calls and does not alter return values" do
    assert InterceptAll.sum(1, 2) == 3
    assert InterceptAll.concat("a", "b") == "ab"

    assert ListStore.all == ["Other: ab", "Integer: 3"]
  end

  defmodule InterceptSome do
    use Interceptor, callback: &Logger.call/1, only: {:sum}

    def sum(a, b), do: a + b
    def concat(left, right), do: left <> right
  end

  test "only intercepts chosen functions" do
    assert InterceptSome.sum(1, 2) == 3
    assert InterceptSome.concat("a", "b") == "ab"

    assert ListStore.all == ["Integer: 3"]
  end
end
