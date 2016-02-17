defmodule CharacterCount do
  import IO, only: [gets: 1, puts: 1]
  @question "What is the input string?\n"

  def ask do
    gets(@question)
  end

  def count(input) do
    chars = String.rstrip(input) |> String.length |> Integer.to_string
    puts(String.rstrip(input) <> " has " <> chars <> " characters.")
  end
end

CharacterCount.ask |> CharacterCount.count
