defmodule X2.Interpreter do
  def eval({:+, a, b}),
    do: a + b
end
