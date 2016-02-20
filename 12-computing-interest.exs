defmodule ComputingInterest do
  @doc """
  computes interest values after a certain number of years have passed based on initial investment
  """

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]

  @doc """
  ask for investment, interest and time to invest
  """
  def ask do
    {ask_investment, ask_interest_rate / 100, ask_years}
  end

  @doc """
  calculate the total amount of gained at the rate given after an amount of time
  """
  def calculate({investment, rate, years}) do
    %{
      total_amount: investment * (1 + rate * years),
      rate: rate,
      years: years
    }
  end

  @doc """
  output the result
  """
  def print(%{total_amount: amount, rate: rate, years: years}) do
    puts "After #{years} year(s) of investment at #{rate * 100}%"
    puts "The investment will be worth #{amount}."
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

ComputingInterest.ask
  |> ComputingInterest.calculate
  |> ComputingInterest.print
