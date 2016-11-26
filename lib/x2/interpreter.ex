defmodule X2.Interpreter do
  def eval({op, a, b}) when op in ~w(+ - * / ==)a,
    do: apply(Kernel, op, [a, b])

  def eval(list) when is_list(list) do
    Enum.reduce list, fn expression, _last ->
      eval(expression)
    end
  end

  def eval(unknown),
    do: raise RuntimeError, "Unknown syntax #{inspect unknown}"
end
