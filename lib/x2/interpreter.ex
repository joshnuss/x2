defmodule X2.Interpreter do
  def eval({op, a, b}) when op in ~w(+ - * /)a,
    do: apply(Kernel, op, [a, b])

  def eval(unknown),
    do: raise RuntimeError, "Unknown syntax #{inspect unknown}"
end
