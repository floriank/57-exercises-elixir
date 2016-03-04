defmodule PasswordGenerator do
  @moduledoc """
  A password generator, asks the user for a set of inputs and then generates a password from multiple lists
  """

  @numbers 0..9
  @special ~w(! @ # $ % ^ & * _ - + /)
  @characters ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

  import IO, only: [gets: 1, puts: 1]
  import Integer, only: [parse: 1]

  @doc """
  ask the user for options
  """
  def ask do
    %{
      length:  question("What's the minimum length?"),
      special: question("How many special characters?"),
      numbers: question("How many numbers?")
    }
  end

  @doc """
  generate a password based on the options passed
  """
  def generate(%{length: length, special: special, numbers: numbers}) do
    if length <= special || length <= numbers do
      length = length + special + numbers
    end
    n = Enum.take_random(@numbers, numbers)
      |> Enum.map(&to_string/1)
    s = Enum.take_random(@special, special)
    c = Enum.take_random(@characters, length) |> Enum.join

    Enum.to_list(1..10)
    |> Enum.into([], fn (_) -> replace(c, s ++ n) end)
  end

  defp question(text) do
    value = gets(text <> " ")
      |> parse
    case value do
      :error ->
        puts("Not a valid answer! Try again:")
        question(text)
      {value, _} -> value
    end
  end

  defp replace(str, symbols) do
    str = String.to_char_list(str)
    Enum.take_random(str, length(str) - length(symbols)) ++ symbols
      |> Enum.shuffle
      |> to_string
  end
end

PasswordGenerator.ask
  |> PasswordGenerator.generate
  |> Enum.join("\n")
  |> IO.puts
