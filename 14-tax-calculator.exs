defmodule TaxCalculator do
  @moduledoc """
  provides tax calculation based on the state of the user
  """

  import String, only: [rstrip: 1, upcase: 1]
  import IO, only: [gets: 1, puts: 1]

  @tax_rate 5.5

  @doc """
  ask the user for input
  """
  def ask do
    {ask_amount, ask_state}
  end

  @doc """
  calculate the tax
  """
  def calculate({amount, state}) do
    cond do
      state == "WI" ->
        tax =  amount * (@tax_rate / 100)
        %{total: amount, tax: tax, total_with_tax: tax + amount }
      true ->
        %{total: amount, tax: 0, total_with_tax: amount }
    end
  end

  @doc """
  prints the output if no tax was calculated
  """
  def print(%{total: total, tax: 0, total_with_tax: _}) do
    puts "The total is #{Float.to_string(total, decimals: 2)}"
  end

  @doc """
  prints the output if the tax was calculated
  """
  def print(%{total: total, tax: tax, total_with_tax: total_with_tax}) do
    puts "The subtotal is #{Float.to_string(total, decimals: 2)}"
    puts "The tax is #{Float.to_string(tax, decimals: 2)}"
    puts "The total is #{Float.to_string(total_with_tax, decimals: 2)}"
  end

  defp ask_amount do
    amount = gets("What is the order amount? ")
      |> rstrip
      |> Float.parse
    if amount == :error do
      ask_amount
    end
    {amount, _} = amount
    amount
  end

  def ask_state do
    gets("What is the state? ")
      |> rstrip
      |> upcase
  end
end

TaxCalculator.ask
  |> TaxCalculator.calculate
  |> TaxCalculator.print
