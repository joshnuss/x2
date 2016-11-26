defmodule X2.Interpreter do
  def eval(ast, binding \\ %{}) do
    {_binding, value} = do_eval(ast, binding)

    value
  end

  defp do_eval({op, lhs, rhs}, binding) when op in ~w(+ - * / ==)a do
    values = [eval(lhs, binding),
              eval(rhs, binding)]

    {binding, apply(Kernel, op, values)}
  end

  defp do_eval(list, binding) when is_list(list) do
    Enum.reduce list, {binding, nil}, fn expression, {binding, _last} ->
      do_eval(expression, binding)
    end
  end

  defp do_eval({:"=", name, expression}, binding) do
    literal = eval(expression, binding)
    binding = Map.put(binding, name, literal)

    {binding, literal}
  end

  defp do_eval({:call, name, []}, binding) do
    value = Map.fetch!(binding, name)

    {binding, value}
  end

  defp do_eval(literal, binding) when is_number(literal),
    do: {binding, literal}

  defp do_eval(unknown, _binding),
    do: raise RuntimeError, "Unknown syntax #{inspect unknown}"
end
