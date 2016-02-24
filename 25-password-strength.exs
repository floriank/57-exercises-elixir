defmodule PasswordStrength do
  @moduledoc """
  A module for password checking
  """


  import String, only: [rstrip: 1]
  import IO, only: [gets: 1, puts: 1]

  @doc """
  ask the user for an input, then evaluate the password given
  """
  def ask_password do
    password = question("What is your desired password?")
      |> evaulate_password

    case password do
      :very_weak ->
        puts "Very weak password!"
      :weak ->
        puts "Weak password!"
      :strong ->
        puts "Strong password!"
      :very_strong ->
        puts "Very strong password!"
    end
  end

  @doc """
  evaluate a password given.

  Output/Rules:

  - :very_weak | A very weak password contains only numbers and is fewer than eight characters.
  - :weak | A weak password contains only letters and is fewer than eight characters.
  - :strong | A strong password contains letters and at least one number and is at least eight characters.
  - :very_strong | A very strong password contains letters, numbers, and special characters and is at least eight characters.
  """
  def evaulate_password(password) do
    case evaluate(password) do
      {:only_numbers, :low_characters} -> :very_weak
      {:only_letters, :low_characters} -> :weak
      {:one_number, :high_characters} -> :strong
      {:one_number, :one_special_character, :high_characters} -> :very_strong
      _ -> :very_weak
    end
  end

  defp evaluate(password) do
    only_numbers = false
    only_letters = false
    one_number = false
    high_characters = String.length(password) >= 8
    low_characters = !high_characters
    case Float.parse(password) do
      {_, ""} -> only_numbers = true
      {_, _} -> one_number = true
      :error -> only_letters = true
    end

    one_special_character = Regex.match?(~r([^0-9a-zA-Z *]), password)

    cond do
      # there are many cases missing, but these will default to :very_weak for now, as new properties can be added in the future,
      # e.g. passwords with only numbers longer than the 8 char limit or passwords too short but consisting of less than 8 chars
      only_numbers && low_characters -> {:only_numbers, :low_characters}
      only_letters && low_characters -> {:only_letters, :low_characters}
      one_number && high_characters -> {:one_number, :high_characters}
      one_number && one_special_character && high_characters -> {:one_number, :one_special_character, :high_characters}
      true -> nil # default to very weak for combinations we do not acknowledge
    end
  end

  defp question(text) do
    gets(text <> " ")
      |> rstrip
  end
end

PasswordStrength.ask_password
