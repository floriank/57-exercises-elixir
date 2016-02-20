defmodule Retirement do
  import IO, only: [gets: 1, puts: 1]
  import Integer, only: [parse: 1]
  import String, only: [rstrip: 1]

  @age_question "What is your current age? "
  @retirement_age "At what age do you want to retire? "

  def ask_age(age \\ @age_question, retirement \\ @retirement_age) do
    age = gets(age)
      |> rstrip
      |> parse

    retirement = gets(retirement)
      |> rstrip
      |> parse

    case { age, retirement } do
      {:error, _} ->
        puts "Age is not a usable number! Try again!"
        ask_age
      {_, :error} ->
        puts "Retirement age is not usable! Try again!"
        ask_age
      { { a, _ }, { b, _ } } -> %{ age: a, retirement: b }
    end
  end

  def calculate(%{age: age, retirement: retirement}) do
    left_years_to_work = retirement - age
    %{retirement_year: current_year + left_years_to_work, years_left: left_years_to_work}
  end

  def print(%{retirement_year: work_until, years_left: years}) do
    if years < 1 do
      puts "You can already retire!"
    else
      puts "You have " <> Integer.to_string(years) <> " years left to work."
      puts "It is " <> Integer.to_string(current_year) <> ", so you can retire in " <> Integer.to_string(work_until)
    end
  end

  defp current_year do
    # use erlang
    { {year, _, _}, _ } = :os.timestamp |> :calendar.now_to_datetime
    year
  end
end


Retirement.ask_age
  |> Retirement.calculate
  |> Retirement.print
