defmodule PayingOffCreditCard do
  @doc """
  A module to determine how long it takes to pay off a credit card
  """

  import String, only: [rstrip: 1]
  import IO, only: [gets: 1, puts: 1]

  @doc """
  Ask the user for input, then use calculate to determine the time it takes to pay off the card
  """
  def ask do
    balance = pose_question("What is the balance?", Float)
    apr     = pose_question("What is the APR on the card?", Float) / 100 # percentage
    payment = pose_question("What is the monthly payment you can make?", Float)

    result_in_months = calculate(balance, apr, payment)

    puts "It will take you #{Float.to_string(result_in_months, decimals: 0)} months to pay off that card!"
  end

  @doc """
  A function to calculate the remaining time to pay of a credit card. Result in months
  """
  def calculate(balance, apr, payment_per_month) do
    i = apr / 365
    quot = :math.log(1 + ((balance/payment_per_month) * (1 - :math.pow(1 + i, 30)))) / :math.log(1 + i)
    Float.round(-1/30 * quot, 0)
  end

  defp pose_question(question, module) do
    value = gets(question <> " ")
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

PayingOffCreditCard.ask
