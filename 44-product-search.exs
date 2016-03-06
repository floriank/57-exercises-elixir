defmodule ProductSearch do
  @moduledoc """
  A module that allows search of as JSON file
  """

  import IO, only: [gets: 1, puts: 1]

  def search do
    case query("What's the product name? ('q' to end)") do
      {:ok, product} ->
         puts "Name: #{product["name"]}"
         puts "Price: #{product["price"]}"
         puts "Quantity on hand: #{product["quantity"]}"
      {:error, _} ->
        puts "Sorry, no product was not! Try again:"
        search
      {:abort } -> Process.exit(self, :kill)
    end
  end

  defp query(text) do
    value = gets(text <> " ") |> String.rstrip
    case value do
      "q" -> {:abort}
      _ ->
        products = Enum.filter(json, fn item ->
          String.downcase(item["name"])
            |> String.contains?(value)
        end)

        if length(products) == 1 do
          {:ok, List.first(products)}
        else
          {:error, products}
        end
    end
  end

  defp json do
    {:ok, json} = File.read("files/products.json")
    Poison.Parser.parse!(json)["products"]
  end
end

ProductSearch.search
