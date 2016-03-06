defmodule WordFrequency do
  @moduledoc """
  A module that takes a file and counts distinguishable words
  """
  @default_file "files/46-words.txt"

  import IO, only: [puts: 1]

  @doc """
  default action
  """
  def read do
    read(@default_file)
  end

  @doc """
  read in a given file
  """
  def read(file) do
    case File.open(file, [:read, :compressed]) do
      {:ok, device} -> IO.read device, :all
      {:error, _} -> :error
    end
  end

  @doc """
  erro case for count
  """
  def count(:error) do
    puts "Nothing to count, since the file could not be read."
  end

  @doc """
  produce a map that counts the occurences of every word in the text
  """
  def count(contents) do
    String.split(contents, " ")
      |> Enum.map(&String.strip/1)
      |> reject_empty
      |> replace_special
      |> count_occurences(%{})
  end

  @doc """
  print a map of how often a word is included in a map
  """
  def print(map) do
    Enum.sort(map, fn {_, left}, {_, right} -> left >= right end)
    |> Enum.each(fn {word, occurences} -> puts "#{word}: #{stars(occurences)}" end)
  end

  defp stars(number) do
    cond do
      number > 40 -> 1..40
      true -> Range.new(1, number)
    end
    |> Enum.map(fn _ -> "*" end)
    |> Enum.join
    |> numbers(number)
  end

  defp count_occurences([], acc), do: acc

  defp count_occurences([ head | tail], acc) do
    value = cond do
      Map.has_key?(acc, head) -> acc[head] + 1
      true -> 1
    end
    count_occurences(tail, Map.put(acc, head, value))
  end

  defp numbers(stars, number) when number > 40 do
    "#{stars} (#{number})"
  end

  defp numbers(stars, _) do
    stars
  end

  defp replace_special(list) do
    Stream.map(list, fn(item) ->
      Task.async(fn() ->
        String.replace(item, ~r/[^\w\s]/, "")
        |> String.downcase
      end)
    end)
    |> Enum.map(&Task.await/1)
  end

  defp reject_empty(list) do
    Enum.reject(list, fn (word) -> String.match?(word, ~r/[^\w\s]/) end)
    |> Enum.reject(fn item -> String.length(item) == 0 end)
  end
end

WordFrequency.read("files/shakespeare.txt.gz")
  |> WordFrequency.count
  |> WordFrequency.print
