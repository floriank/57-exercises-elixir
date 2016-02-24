defmodule TemperatureConverter do
  @moduledoc """
  converts from fahrenheit to celsius and vise-versa
  """

  import IO, only: [puts: 1, gets: 1, read: 2]
  import String, only: [rstrip: 1, downcase: 1]

  def choose_temperature do
    puts "Choose c for Celsius to Fahrenheit"
    puts "Choose f for Fahrenheit to Celsius"
    case read(:stdio, :line) do
      :eof -> :ok
      {:error, reason} ->
        IO.inspect reason
        choose_temperature
      data ->
        char = data
          |> rstrip
          |> downcase

        cond do
          char == "f" || char == "c" ->
            puts "Your choice: #{char}"
            set_temp(char)
            |> ask_input
          true ->
            puts "Please choose either \"c\" or \"f\"!"
            choose_temperature
        end
    end
  end

  defp set_temp("f") do
    %{to: :celsius}
  end

  defp set_temp("c") do
    %{to: :fahrenheit}
  end

  defp ask_input(params) do
    degrees = gets("What's the temperature? ")
      |> rstrip
      |> Float.parse
    case degrees do
      :error ->
        puts "Please enter a valid temperature!"
        ask_input(params)
      { degrees, _ } ->
        Map.put params, :degrees, degrees
    end
  end

  @doc """
  calculate the conversion from fahrenheit to celsius
  """
  def calculate(%{to: :celsius, degrees: degrees}) do
    {:celsius, (degrees - 32) * 5/9}
  end

  @doc """
  calculate the conversion from celsius to fahrenheit
  """
  def calculate(%{to: :fahrenheit, degrees: degrees}) do
    {:fahrenheit, (degrees * 9/5) + 32}
  end

  @doc """
  print the result for a result in celsius
  """
  def print_result({:celsius, number}) do
    puts "That's #{Float.to_string(number, decimals: 3)} deg Celsius"
  end


  @doc """
  print the result for a result in fahrenheit
  """
  def print_result({:fahrenheit, number}) do
    puts "That's #{Float.to_string(number, decimals: 3)} deg Fahrenheit"
  end
end


TemperatureConverter.choose_temperature
  |> TemperatureConverter.calculate
  |> TemperatureConverter.print_result
