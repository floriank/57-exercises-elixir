defmodule SimpleMath do
  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]

  def ask do
    a = rstrip(gets("What is the first number? "))
    b = rstrip(gets("What is the second number? "))
    {a, b}
  end

  def print({a, b}) do
    {a, _} = Float.parse(a)
    {b, _} = Float.parse(b)
    numbers = { a, b }
    puts Enum.join([
      sum(numbers),
      diff(numbers),
      prod(numbers),
      quot(numbers)
    ], "\n")
  end

  defp sum({a, b}) do
    output(a) <> " + " <> output(b) <> " = " <> output(a + b)
  end

  defp diff({a, b}) do
    output(a) <> " - " <> output(b) <> " = " <> output(a - b)
  end

  defp prod({a, b}) do
    output(a) <> " * " <> output(b) <> " = " <> output(a * b)
  end

  defp quot({_, b}) when b == 0 do
    "not possible to calculate quotient due to divisor being 0"
  end

  defp quot({a, b})  do
    output(a) <> " / " <> output(b) <> " = " <> output(a / b)
  end

  defp output(float) do
    Float.to_string(float, compact: true, decimals: 2)
  end
end

SimpleMath.ask |> SimpleMath.print
