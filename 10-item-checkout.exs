defmodule ItemCheckout do
  @doc """
  The module implements a simple checkout by asking the user for a number of items then calculating a total with tax amount

  This uses the US model, in most European states tax is already included in the prices of items. Users there will therefore input the actual price and totals will be calculated afterwards
  """

  @tax_rate_in_percent 5.5

  import String, only: [rstrip: 1]
  import IO, only: [gets: 1, puts: 1]

  @doc """
  Ask the user for an arbitrary item count
  """
  def ask_item_count do
    item_count = gets("How many items do you have? ")
      |> rstrip
      |> Integer.parse

    cond do
      item_count == :error ->
        puts "Not a valid item count! Try again!"
        ask_item_count
      true ->
        { item_count, _ } = item_count
        cond do
          item_count < 1->
            puts "Item count must be greater than zero! Try again!"
            ask_item_count
          true -> item_count
        end
    end
  end

  @doc """
  ask prices for each item
  """
  def ask_prices_and_quantity(number_of_items, totals \\ 0.0, times_called \\ 1) do
    case number_of_items do
      0 -> totals
      _ ->
        { price, _ } = gets("What is the price of item #{times_called}? ")
          |> rstrip
          |> Float.parse
        ask_prices_and_quantity(number_of_items - 1, totals + price, times_called + 1)
    end
  end

  @doc """
  calculates the total tax and the tax amount
  """
  def calculate_tax(totals) do
    tax = @tax_rate_in_percent / 100 * totals
    %{ net_total: totals, tax_amount: tax, total: totals + tax }
  end

  @doc """
  prints the result
  """
  def print(%{ net_total: net_total, tax_amount: tax, total: totals }) do
    puts "You have a net total of #{Float.round(net_total, 2)}"
    puts "Tax amount: #{Float.round(tax, 2)}"
    puts "Totals: #{Float.round(totals, 2)}"
  end
end


ItemCheckout.ask_item_count
  |> ItemCheckout.ask_prices_and_quantity
  |> ItemCheckout.calculate_tax
  |> ItemCheckout.print
