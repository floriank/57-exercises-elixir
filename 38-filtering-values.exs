defmodule FilterValues do
  @moduledoc """
  A module for filtering values in a given input, using mostly my own algorithms instead of relying on built in functions
  """

  import IO, only: [gets: 1, puts: 1]

  @doc """
  ask the user for some numbers
  """
  def ask do
    gets("Enter a list of numbers, space separated! ")
      |> String.rstrip
      |> String.split(" ")
      |> Enum.map(&Integer.parse/1)
  end

  def filter_even_numbers(arr \\ [], acc \\ [])

  def filter_even_numbers([:error | tail], acc) do
    filter_even_numbers(tail, acc)
  end

  def filter_even_numbers([{ value, _} | tail], acc) do
    if rem(value, 2) == 0 do
      acc = acc ++ [value]
    end
    filter_even_numbers(tail, acc)
  end

  def filter_even_numbers([], acc) do
    acc
  end
end

numbers = FilterValues.ask
  |> FilterValues.filter_even_numbers
  |> Enum.join(" ")
IO.puts "The even numbers are: #{numbers}"
