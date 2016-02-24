defmodule PizzaParty do
  @moduledoc """
    The module deals with calculating the slices of a pizza distributed amongst
    a group of people of the size n, where n is an input given by the user.
  """
  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]
  import Integer, only: [parse: 1]

  @slices_per_pizza 8

  @doc """
  Ask the user for inputs (pizza and people), try again if not properly done
  """
  def ask do
    people = question("How many people do want pizza? ")
    pizza = question("How many pizzas do you have? ")

    case {pizza, people} do
      {:error, _} ->
        puts "The number of pizzas must be whole! Try again!"
        ask
      {_, :error} ->
        puts "The number of people must be whole! Try again!"
        ask
      {{ pizza, _}, {people, _}} ->
        %{ people: people, pizza: pizza }
    end
  end

  @doc """
  Calculates the slices that each person gets and returns a tuple with the result and the leftovers
  """
  def calculate(%{pizza: pizza, people: people}) do
    {
      div(pizza * @slices_per_pizza, people),
      rem(pizza * @slices_per_pizza, people)
    }
  end

  @doc """
  Print the result, checking for actual results. If the result is zero, no one gets any pizza
  """
  def print({result, leftovers}) do
    case result do
      0 ->
        puts "No one is getting any pizza :-("
      _ ->
        puts "You get " <> Integer.to_string(result) <> " " <> slices(result) <> " per person!"
        puts "You have " <> Integer.to_string(leftovers) <> " " <>  slices(leftovers) <> " as leftovers!"
    end
  end

  defp question(sentence) do
    gets(sentence)
      |> rstrip
      |> parse
  end

  defp slices(number) do
   if number == 1 do
     "slice"
   else
     "slices"
   end
  end
end

# Test invocation
PizzaParty.ask
  |> PizzaParty.calculate
  |> PizzaParty.print
