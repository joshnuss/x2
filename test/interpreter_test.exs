defmodule X1.Interpreter.Test do
  use ExUnit.Case

  import X2.Interpreter

  test "errors when syntax unknown" do
    assert_raise RuntimeError, ~r/Unknown/, fn ->
      eval(:oops)
    end
  end

  describe "literal" do
    test "addition" do
      assert eval({:+, 1, 2}) == 3
    end

    test "subtraction" do
      assert eval({:-, 1, 5}) == -4
    end

    test "multiplication" do
      assert eval({:*, 3, 5}) == 15
    end

    test "division" do
      assert eval({:/, 15, 2}) == 7.5
    end
  end
end
