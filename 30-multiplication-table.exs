defmodule MultiplicationTable do
  @moduledoc """
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
      {number, ""} -> { number, number }
      {_, _} ->
        puts "Please enter a whole number!"
        ask
    end
  end

  @doc """
  print one multiplication "table" column (the number)
  """
  def display_table_column({ number, multiplicator }) do
    number = abs(number)
    if multiplicator != -1 do
      puts "#{number} x #{multiplicator} =  #{number * multiplicator}"
      display_table_row({ number - 1, multiplicator})
      display_table_column({ number, multiplicator - 1 })
    end
  end

  @doc """
  print one multiplication "table" row (the multiplicator)
  """
  def display_table_row({ number, multiplicator }) do
    if number != -1 do
      puts "#{number} x #{multiplicator} =  #{number * multiplicator}"
      display_table_row({ number - 1, multiplicator })
    end
  end
end

MultiplicationTable.ask |> MultiplicationTable.display_table_column

