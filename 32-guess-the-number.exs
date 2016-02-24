defmodule GuessTheNumber do
  @moduledoc """
  a simple game to guess a number
  """

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1, slice: 3, downcase: 1]

  def start! do
    puts "Let's play a guessing game."
    difficulty = ask("What difficutly would you like? (1, 2 or 3)")

    play(difficulty)
  end

  defp play(difficulty) do
    number = generate_number(difficulty)
    loop "Guess the number", number
  end

  defp loop(question, number, tries \\ 1) do
    guess = gets(question <> " ")
      |> Integer.parse
    case guess do
      :error ->
        puts "That's a silly answer - try again:"
        loop(question, number, tries)
      {guess, _} ->
        if guess == number do
          end_game(number, tries)
        else
          if number > guess do
            puts "Higher!"
          else
            puts "Lower!"
          end
          loop("That's not correct - Try again:", number, tries + 1)
        end
    end
  end

  defp end_game(number, tries) do
    puts "Hooray! That's correct! #{number} was the number I had in mind!"
    case tries do
      1 -> puts "You are a mind reader!"
      value when value in 2..4 -> puts "Most impressive!"
      value when value in 5..7 -> puts "You can do better than that!"
      value when value > 7 -> puts "Better luck next time!"
    end

    play_again = gets("Want to play again? ")
      |> rstrip
      |> slice(0, 1)
      |> downcase

    if play_again == "y" do
      start!
    end
  end

  defp generate_number(diff) do
    :random.seed(:os.timestamp)
    case diff do
      1 -> 1..10
      2 -> 1..100
      3 -> 1..1000
    end
    |> Enum.random
  end

  def ask(question) do
    value = gets(question <> " ")
      |> rstrip
      |> Integer.parse

    case value do
      :error ->
        puts "That value is invalid!"
        ask(question)
      {value, _} when value in 1..3 -> value
      {_, _} ->
        puts "That's outside of the possible difficulty range! (1 - 3)"
        ask(question)
    end
  end
end

GuessTheNumber.start!
