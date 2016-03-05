defmodule NameSorter do
  @moduledoc """
  a module to read in a list of strings, then sort them
  """

  import IO, only: [puts: 1]

  @doc """
  read in a file by a given name
  """
  def read(file) do
    case File.read file do
      {:ok, file} -> readlines(file)
      {:error, _} ->
        puts "not a proper file"
    end
  end

  defp readlines(contents) do
    names = String.split(contents, "\n")
      |> Enum.sort
      |> Enum.reject(fn(str) -> str == "" end)

    {length(names), Enum.join(names, "\n")}
  end
end

{number, names} = NameSorter.read("files/names.txt")

IO.puts "There are #{number} names:"
IO.puts "--------------------------"
IO.puts names

