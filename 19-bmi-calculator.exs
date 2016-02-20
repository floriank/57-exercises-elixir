defmodule BmiCalculator do
  @doc """
  calulates the bmi given a persons measurements
  """

  import IO, only: [puts: 1, gets: 1, read: 2]
  import String, only: [rstrip: 1, downcase: 1]

  def choose_system do
    puts "Choose m for metric system"
    puts "Choose i for imperial system"
    case read(:stdio, :line) do
      :eof -> :ok
      {:error, reason} ->
        IO.inspect reason
        choose_system
      data ->
        char = data
          |> rstrip
          |> downcase

        cond do
          char == "i" || char == "m" ->
            puts "Your choice: #{char}"
            set_system(char)
            |> ask_input
          true ->
            puts "Please choose either \"m\" or \"i\"!"
            choose_system
        end
    end
  end

  def calculate(%{system: :metric, height: height, weight: weight}) do
    height = height / 100
    (weight / (height * height))
  end

  def calculate(%{system: :imperial, height: height, weight: weight}) do
    (weight / (height * height)) * 703
  end

  def print_result(bmi) do
    puts "Your BMI is #{Float.to_string(bmi, decimals: 2)}"
    cond do
      bmi <= 18.5 ->
        puts "You're underweight."
      18.5 < bmi && bmi <= 24.9 ->
        puts "You're in the normal range."
      24.9 < bmi && bmi <= 29.9 ->
        puts "You're overweight."
      bmi > 29.9 ->
        puts "You're obese. See a doctor."
      true ->
        puts "Nothing to say about it."
    end
  end

  defp ask_input(%{using: :metric}) do
    params = ask_height_and_weight :metric
    Map.put params, :system, :metric
  end

  defp ask_input(%{using: :imperial}) do
    params = ask_height_and_weight :imperial
    Map.put params, :system, :metric
  end

  defp ask_height_and_weight(type) do
    weight_addendum = if type == :metric, do: "(in kg)", else: "(in pounds)"
    height_addendum = if type == :metric, do: "(in cm)", else: "(in inches)"
    weight = gets("What is your weight? #{weight_addendum} ")
      |> rstrip
      |> Float.parse
    height = gets("What is your height? #{height_addendum} ")
      |> rstrip
      |> Float.parse
    case { weight, height } do
      { :error, _} ->
        puts "Try again! That weight is not a number!"
        ask_height_and_weight type
      { _, :error } ->
        puts "Try again! That height is not a number!"
        ask_height_and_weight type
      { { weight, _ }, { height, _ } } ->
        %{ height: height, weight: weight}
    end
  end

  defp set_system("m") do
    %{using: :metric}
  end

  defp set_system("i") do
    %{using: :imperial}
  end
end

BmiCalculator.choose_system
  |> BmiCalculator.calculate
  |> BmiCalculator.print_result
