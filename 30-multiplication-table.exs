defmodule MultiplicationTable do
  @doc """
  a program to display a multiplication table
  """

  import Integer, only: [parse: 1]
  import String, only: [rstrip: 1]
  import IO, only: [gets: 1, puts: 1]

  @doc """
  ask the user for input, return the input as a whole number
  """
  def ask do
    number = gets("What's the number? ")
      |> rstrip
      |> parse
    case number do
      :error ->
        puts "Not a number!"
        ask
      {number, ""} -> number
      {_, _} ->
        puts "Please enter a whole number!"
        ask
    end
  end

  @doc """
  print a simple multiplication "table"
  """
  def display_table(number) do
    for n <- Range.new(0, number) do
      for m <- Range.new(0, n) do
        puts "#{n} x #{m} = #{n * m}"
      end
    end
  end
end

MultiplicationTable.ask |> MultiplicationTable.display_table

