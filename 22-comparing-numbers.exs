defmodule ComparingNumbers do
  @doc """
  the module finds the highest out of three given numbers, using no library builtin or otherwise
  """

  import IO, only: [gets: 1, puts: 1]

  def ask_numbers do
    {ask("first"), ask("second"), ask("third")}
  end

  def calculate({first, second, third}) do
    if first == second == third do
      {:error, "All the same"}
    else
      {:ok, find_highest([first, second, third], first)}
    end
  end

  def print({:ok, number}) do
    puts "The highest number is #{number}"
  end

  def print({:error, reason}) do
    puts reason
  end

  defp find_highest([], highest) do
    highest
  end

  defp find_highest([head | tail], highest) do
    if head >= highest do
      find_highest(tail, head)
    else
      find_highest(tail, highest)
    end
  end


  defp ask(prefix) do
    number = gets("What's the #{prefix} number? ")
      |> String.rstrip
      |> Integer.parse

    case number do
      :error ->
        puts "That is not a number! Try again:"
        ask(prefix)
      { number, _ } -> number
    end
  end
end

ComparingNumbers.ask_numbers
  |> ComparingNumbers.calculate
  |> ComparingNumbers.print
