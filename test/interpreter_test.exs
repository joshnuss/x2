defmodule X1.Interpreter.Test do
  use ExUnit.Case

  import X2.Interpreter

  describe "literal" do
    test "addition" do
      assert eval({:+, 1, 2}) == 3
    end

    test "subtraction" do
      assert eval({:-, 1, 5}) == -4
    end
  end
end
