defmodule SimpleMath do
  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]

  @first_number "What is the first number? "
  @second_number "What is the second number? "

  def ask(first_question \\ @first_number, second_question \\ @second_number) do
    a = Float.parse(rstrip(gets(first_question)))
    b = Float.parse(rstrip(gets(second_question)))

    case {a, b} do
      {:error, _} -> ask("First number is not a number - try again! " <> @first_number)
      {_, :error} -> ask("Second nuber is not a number - try again! " <> @second_number)
      { { a , _ }, { b, _ } } -> { a, b }
    end
  end

  def print(numbers) do
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
