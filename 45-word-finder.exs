defmodule WordFinder do
  @moduledoc """
  a module to read a file, let the user search a replacement for any given word
  """

  import IO, only: [gets: 1, puts: 1]

  @input_file "files/45-words.txt"

  @doc """
  dummy for read(file)
  """
  def read do
    read(false)
  end

  @doc """
  read in a given file
  """
  def read(file) do
    case File.read(file || @input_file) do
      {:ok, contents} -> contents
      {:error, _} -> :error
    end
  end

  def prompt(:error) do
    puts "Cannot read file. Abort."
  end

  def prompt(contents) do
    puts contents
    word = gets("What word to replace? ") |> String.rstrip
    replacement = gets("What should it be replaced with? ") |> String.rstrip

    String.replace(contents, word, replacement)
  end

  def prompt_output(new_content) do
    puts new_content
    output_file = gets("What is the name of the output file? ('n' for no output) ") |> String.rstrip

    case output_file do
      "n" -> :abort
      _ -> {:ok, output_file, new_content}
    end
  end

  def write(:abort) do
    puts "Nothing to write. done."
  end

  def write({:ok, filename, new_content}) do
    case File.open("files/#{filename}", [:write]) do
      {:ok, device} ->
        IO.write device, new_content
        puts "New contents written to ./files/#{filename}!"
      {:error, reason} -> puts "Cannot write! #{reason}"
    end
  end
end

WordFinder.read
  |> WordFinder.prompt
  |> WordFinder.prompt_output
  |> WordFinder.write
