defmodule CharacterCount do
  @moduledoc """
  a module to count characters
  """
  import IO, only: [gets: 1, puts: 1]
  @question "What is the input string?\n"

  def ask do
    gets(@question)
  end

  def count(input) do
    str = String.rstrip(input)
    case String.length(str) do
      0 ->
        puts("Can't calculate length without a name")
      count ->
        chars = Integer.to_string(count)
        puts(String.rstrip(input) <> " has " <> chars <> " characters.")
    end
  end
end

CharacterCount.ask |> CharacterCount.count
