defmodule Anagrams do

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1, downcase: 1, replace: 3]

  def ask do
    first = question("What is the first word?")
    second = question("What is the second word?")

    if anagram?(first, second) do
      puts "These words are anagrams of each other."
    else
      puts "These two are not anagrams of each other."
    end
  end

  defp question(text) do
    gets(text <> " ")
      |> rstrip
      |> downcase
      |> replace(" ", "")
  end

  defp anagram?(first, second) do
    first_list = String.to_char_list(first)
    second_list = String.to_char_list(second)

    if length(first_list) == length(second_list) do
      # map out each character in the list check if maps match
      count_occurences(first_list) == count_occurences(second_list)
    else
      false
    end
  end

  defp count_occurences(list, acc \\ %{})

  defp count_occurences([], acc), do: acc

  defp count_occurences([head | tail], acc) do
    if Map.has_key?(acc, head) do
      count_occurences(tail, Map.put(acc, head, Map.get(acc, head) + 1))
    else
      count_occurences(tail, Map.put(acc, head, 1))
    end
  end

end

Anagrams.ask
