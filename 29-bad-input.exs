defmodule BadInput do
  @moduledoc """
  the module implements rule of 72, a quick way to estimate how long it will take to double an investment

  The focus is on handling all the bad inputs associated with the division of two number - 72 and the input
  """

  import IO, only: [gets: 1, puts: 1]
  import Float, only: [parse: 1]

  @doc """
  ask for user input
  """
  def ask do
    number = gets("What is the rate of return? ")
      |> parse

    case number do
      :error ->
        puts "That is not a number!"
        ask
      {0.0, _} ->
        puts "Zero is not allowed!"
        ask
      {number, _} ->
        years = calculate(number)
        puts "It will take approx. #{Float.to_string(years, decimals: 2)} years to double your investment"
    end
  end

  def calculate(rate) do
    72 / rate
  end
end

BadInput.ask
