defmodule X2.Interpreter do
  def eval(ast),
    do: to_literal(ast, %{})

  defp do_eval({op, a, b}, binding) when op in ~w(+ - * / ==)a do
    aval = to_literal(a, binding)
    bval = to_literal(b, binding)

    {binding, apply(Kernel, op, [aval, bval])}
  end

  defp do_eval(list, binding) when is_list(list) do
    Enum.reduce list, {binding, nil}, fn expression, {binding, _last} ->
      do_eval(expression, binding)
    end
  end

  defp do_eval({:"=", name, expression}, binding) do
    literal = to_literal(expression, binding)
    binding = Map.put(binding, name, literal)

    {binding, literal}
  end

  defp do_eval({:call, name, []}, binding) do
    value = Map.fetch!(binding, name)

    {binding, value}
  end

  defp do_eval(unknown, _binding),
    do: raise RuntimeError, "Unknown syntax #{inspect unknown}"

  defp to_literal(literal, _binding) when is_number(literal),
    do: literal
  defp to_literal(expression, binding) do
    {_binding, value} = do_eval(expression, binding)

    value
  end
end
