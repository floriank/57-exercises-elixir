defmodule AddingNumbers do
  @moduledoc """
  a module that adds a total of n numbers
  """
  import Float, only: [parse: 1]
  import IO, only: [puts: 1, gets: 1]

  @count 5

  @doc """
  ask the user how many numbers to add
  """
  def how_many do
    number = gets("How many numbers to add? ")
      |> Integer.parse
    if number == :error do
      puts "Not a number!"
      how_many
    else
      {number, _} = number
      number
    end
  end

  @doc """
  Ask recursively up to @count, then call print the total
  """
  def ask(times \\ @count, added \\ 0, times_called \\ 1) do
    if times == 0 do
      print added
    else
      number = question("What is number ##{times_called}?")
      ask(times - 1, added + number, times_called + 1)
    end

  end

  def print(number) do
    puts "The total is #{number}."
  end

  defp question(text) do
    number = gets(text <> " ") |> parse

    if number == :error do
      question("That is not a number! Try again: ")
    else
      {number, _} = number
      number
    end
  end
end

AddingNumbers.how_many |> AddingNumbers.ask
