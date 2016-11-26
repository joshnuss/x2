defmodule X1.Interpreter.Test do
  use ExUnit.Case

  import X2.Interpreter

  test "addition" do
    assert eval({:+, 1, 2}) == 3
  end
end
