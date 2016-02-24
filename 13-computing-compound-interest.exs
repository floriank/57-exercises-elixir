defmodule ComputingCompundInterest do
  @moduledoc """
  a module that computes compound interest based on the users inputs
  """

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]

  @doc """
  ask the user for inputs
  """
  def ask do
    {ask_investment, ask_interest_rate / 100, ask_years, ask_compound_years}
  end

  @doc """
  calculates the compound interest based on the data given
  """
  def calculate({investment, rate, years, compound_years}) do
    %{
      compound_value: investment * :math.pow((1 + rate / compound_years), years * compound_years),
      rate: rate,
      years: years,
      compound_years: compound_years,
      investment: investment
    }
  end

  @doc """
  output the calculated amount
  """
  def print(%{compound_value: amount, rate: rate, years: years, compound_years: compound_years, investment: investment}) do
    puts "#{Float.to_string(investment, decimals: 2)} invested over #{years} at a rate of #{rate * 100}%, compounded #{compound_years} times a year:"
    puts Float.to_string(amount, decimals: 2)
  end

  defp ask_investment do
    pose_question("What is the initial investment? ", Float)
  end

  defp ask_interest_rate do
    pose_question("What is the interest rate? ", Float)
  end

  defp ask_years do
    pose_question("How long do you plan to invest? ", Integer)
  end

  defp ask_compound_years do
    pose_question("What is the number of times the interest is compounded per year? ", Integer)
  end

  defp pose_question(question, module) do
    value = gets(question)
      |> rstrip
      |> module.parse
    if value == :error do
      pose_question("Try again - the input was invalid! " <> question, module)
    else
      {value, _} = value
      value
    end
  end
end

ComputingCompundInterest.ask
  |> ComputingCompundInterest.calculate
  |> ComputingCompundInterest.print
