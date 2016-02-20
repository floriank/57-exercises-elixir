defmodule NumbersToNames do

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]

  def ask do
    number = gets("Whats's the number of the month? (1 to 12) ")
      |> rstrip
      |> Integer.parse

    case number do
      :error ->
        puts "This is not a number! Try again:"
        ask
      { number,  _ } -> validate number
    end
  end

  def print_month(number) when number in 1..12 do
    month_name = case number do
       1 -> "January"
       2 -> "February"
       3 -> "March"
       4 -> "April"
       5 -> "May"
       6 -> "June"
       7 -> "July"
       8 -> "August"
       9 -> "September"
       10 -> "October"
       11 -> "November"
       12 -> "December"
    end

    puts "The name of the month is #{month_name}"
  end

  defp validate(number) do
    case number do
      number when number in 1..12 ->
        number
      _ ->
        puts "Number does not seem to be within range!"
        ask
    end
  end
end

NumbersToNames.ask
  |> NumbersToNames.print_month
