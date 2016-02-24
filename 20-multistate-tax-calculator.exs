defmodule MultiStateTaxCalulator do
  @moduledoc """
  A tax calculator for multiple states in the US,
  tax is applied when the user lives in wisconsin or illinois,
  extra tax is applied if the county in Wisconsin is Eau Claire or Dunn
  """

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1, downcase: 1, replace: 4]

  @doc """
  ask the user for information on totals and their state
  """
  def ask do
    %{
      total: ask_total,
      state: ask_state
    }
    |> process_state
  end

  @doc """
  calculate the tax total
  """
  def calculate(%{total: total, tax: tax}) do
    cond do
      tax == 0 -> %{ total: total }
      true -> %{ total: total + (total * tax), tax: total* tax }
    end
  end


  @doc """
  print the total if tax was applied
  """
  def print(%{total: total, tax: tax}) do
    puts "Tax is #{Float.to_string(tax, decimals: 2)}"
    puts "Total is #{Float.to_string(total, decimals: 2)}"
  end

  @doc """
  print the total if no tax was applied
  """
  def print(%{total: total}) do
    puts "Total is #{Float.to_string(total, decimals: 2)}"
  end

  defp ask_state do
    state = gets("Which state do you live in? ")
      |> rstrip
      |> downcase
    symbol_from state
  end

  defp ask_total do
    total = gets("What's the total? ")
      |> rstrip
      |> Float.parse

    case total do
      :error ->
        puts "That's not a number! Try again:"
        ask_total
      { total, _ } -> total
    end
  end

  defp process_state(%{state: :wisconsin, total: total}) do
    county = gets("Which county do you live in? ")
      |> rstrip
      |> downcase
      |> replace(" ", "", [])
    case county do
      "eauclaire" ->
        %{ total: total, tax: 0.085 }
      "dunn" ->
        %{ total: total, tax: 0.084 }
      _ ->
        %{ total: total, tax: 0.08 }
    end
  end

  defp process_state(%{state: :illinois, total: total}) do
    %{ total: total, tax: 0.08 }
  end

  defp process_state(params) do
    Map.put params, :tax, 0
  end

  defp symbol_from(input) do
    cond do
      input == "wisconsin" || input == "wi" -> :wisconsin
      input == "illinois" || input == "il" -> :illinois
      true -> nil
    end
  end
end

MultiStateTaxCalulator.ask
  |> MultiStateTaxCalulator.calculate
  |> MultiStateTaxCalulator.print
