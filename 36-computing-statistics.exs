defmodule ComputingStatistics do
  import IO, only: [gets: 1, puts: 1]

  def ask(numbers \\ {}) do
    number = gets("Enter a number: ")
      |> String.rstrip

    if number == "done" do
      Tuple.to_list(numbers)
        |> compute
    else
      case Float.parse(number) do
        :error ->
          puts "Not a number!"
          ask(numbers)
        {number, _} ->
          ask(Tuple.append(numbers, number))
      end
    end
  end

  def compute(numbers) do
    %{
      min: Enum.min(numbers),
      max: Enum.max(numbers),
      average: average(numbers),
      deviation: deviation(numbers),
      original: numbers
    }
  end

  defp average(numbers) do
    Enum.sum(numbers) / length(numbers)
  end

  defp deviation(numbers) do
    average = average(numbers)
    variance = Enum.map numbers, fn (number) ->
      :math.pow((average - number), 2)
    end
    Enum.sum(variance) / length(numbers)
    |> :math.sqrt
  end
end

numbers = ComputingStatistics.ask

IO.puts "Numbers are: #{Enum.join(numbers.original, ", ")}"
IO.puts "Average is: #{numbers.average}"
IO.puts "Minimum is: #{numbers.min}"
IO.puts "Maximum is: #{numbers.max}"
IO.puts "Standard deviation: #{Float.to_string(numbers.deviation, decimals: 2)}"
