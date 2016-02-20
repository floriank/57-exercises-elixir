defmodule BloodAlcoholCalculator do
  @doc """
  decides whether or not a user may drive based on the inputs about alcohol consumed and body measurements given (Bloob alcohol content, BAC)
  """

  import String, only: [rstrip: 1, downcase: 1]
  import IO, only: [gets: 1, puts: 1]

  @legal_limit 0.08

  @doc """
  ask for the initial params and generate a map with the data
  """
  def ask do
    params = %{
      gender: ask_gender,
      weight: ask_weight,
      time_since_last_drink: ask_time_since_last_drink
    }

    alcohol_in_drinks = ask_drinks
      |> collect_alcohol_content

    Map.put(params, :alcohol, alcohol_in_drinks)
  end

  @doc """
  ask for the alcohol content in each drink
  """
  def collect_alcohol_content(drinks, acc \\ 0.0, called \\ 1) do
    case drinks do
      0 -> acc
      _ ->
        amount = pose_question("How much alcohol was in drink ##{called}? (in ounces?) ", Float)
        collect_alcohol_content(drinks - 1, acc + amount, called + 1)
    end
  end

  @doc """
  calculate female BAC
  """
  def calculate(%{gender: :female, weight: weight, time_since_last_drink: time, alcohol: alcohol}) do
    (alcohol * 5.14 / weight * 0.66) - 0.015 * time
  end

  @doc """
  calculate the male BAC
  """
  def calculate(%{gender: :male, weight: weight, time_since_last_drink: time, alcohol: alcohol}) do
    (alcohol * 5.14 / weight * 0.73) - 0.015 * time
  end

  @doc """
  calculate the BAC if the user doe not identify as male or female
  """
  def calculate(%{gender: :none, weight: weight, time_since_last_drink: time, alcohol: alcohol}) do
    # 0.7 is assumed in between male and female as a compromise
    (alcohol * 5.14 / weight * 0.70) - 0.015 * time
  end

  @doc """
  print whether or not it's legal to drive with the given BAC
  """
  def legal?(bac) do
    if bac >= @legal_limit do
      puts "It's not legal to drive with your current BAC (#{bac})"
    else
      puts "You may drive with that BAC (#{bac})"
    end
  end

  defp ask_gender do
    gender = gets("What's you gender? Answer with \"f\", \"m\" or \"none\"! ")
      |> rstrip
      |> downcase
    case gender do
      "f" -> :female
      "m" ->  :male
      "none" -> :none
      _ ->
        puts "Please choose of \"f\", \"m\" or \"none\"!"
        ask_gender
    end
  end

  defp ask_time_since_last_drink do
    pose_question("How many hours since your last drink? ", Integer)
  end

  defp ask_drinks do
    pose_question("How many drinks did you have? ", Integer)
  end

  defp ask_weight do
    pose_question("How much do you weigh? (in absolute pounds) ", Integer)
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

BloodAlcoholCalculator.ask
  |> BloodAlcoholCalculator.calculate
  |> BloodAlcoholCalculator.legal?
