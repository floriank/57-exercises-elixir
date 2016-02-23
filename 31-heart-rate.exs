defmodule HeartRate do
  @doc """
  A program to list the heart rate based on the Karvonen Heart rate formula
  """

  import String, only: [rstrip: 1]
  import IO, only: [gets: 1, puts: 1]

  def ask do
    pulse = question("Enter your resting heart rate:")
    age = question("Enter your age:")
    {age, pulse}
  end

  def draw_table({age, pulse}) do
    puts "|---------------|----------|"
    puts "|   Intensity   |   Rate   |"
    puts "|===============|==========|"
    draw_row(age, pulse)
    puts "|---------------|----------|"
  end

  defp draw_row(age, pulse, percent \\ 55) do
    unless percent > 95 do
      {intensity, rate} = calulcate(age, pulse, percent)
      puts "|   #{intensity}%         |  #{Float.to_string(rate, decimals: 0)}bpm  |"
      draw_row(age, pulse, percent + 5)
    end
  end

  def calulcate(age, pulse, percent) do
    heart_rate = (((220 - age) - pulse) * (percent / 100)) + pulse
    {percent, heart_rate}
  end

  defp question(text) do
    number = gets(text <> " ")
      |> rstrip
      |> Integer.parse

    case number do
      :error ->
        puts "Try again! This is not a number!"
        question(text)
      {number, ""} -> abs(number)
      {_, _} ->
        puts "Please enter a whole number!"
        question(text)
    end
  end
end

HeartRate.ask |> HeartRate.draw_table
