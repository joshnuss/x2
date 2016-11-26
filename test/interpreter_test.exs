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

    test "equality" do
      refute eval({:==, 15, 2})
      assert eval({:==, 15, 15})
    end
  end

  test "running list of expressions" do
    expressions = [
      {:+, 1, 2},
      {:+, 3, 4}
    ]

    assert eval(expressions) == 7
  end

  describe "variable" do
    test "assign" do
      assert eval({:"=", :a, 1}) == 1
    end

    test "read" do
      expressions = [
        {:"=", :a, 1},
        {:call, :a, []}
      ]

      assert eval(expressions) == 1
    end

    test "re-assign" do
      expressions = [
        {:"=", :a, 1},
        {:"=", :a, 3},
        {:call, :a, []}
      ]

      assert eval(expressions) == 3
    end

    test "addition" do
      expressions = [
        {:"=", :a, 77},
        {:+,
          {:call, :a, []},
          {:call, :a, []}
        }
      ]

      assert eval(expressions) == 154
    end

    test "subtraction" do
      expressions = [
        {:"=", :a, 77},
        {:-,
          {:call, :a, []},
          {:call, :a, []}
        }
      ]

      assert eval(expressions) == 0
    end

    test "multiplication" do
      expressions = [
        {:"=", :a, 3},
        {:*,
          {:call, :a, []},
          {:call, :a, []}
        }
      ]

      assert eval(expressions) == 9
    end

    test "division" do
      expressions = [
        {:"=", :a, 10},
        {:/,
          {:call, :a, []},
          {:call, :a, []}
        }
      ]

      assert eval(expressions) == 1
    end

    test "equality" do
      expressions = [
        {:"=", :a, 77},
        {:==,
          {:call, :a, []},
          {:call, :a, []}
        }
      ]

      assert eval(expressions)
    end
  end
end
