defmodule DataParser do
  @moduledoc """
  reads a csv file and then displays it's contents as a table
  """

  import IO, only: [puts: 1]


  @doc """
  read in a given path, transform file contents
  """
  def read(filename) do
    case File.read(filename) do
      {:error, _} -> :error
      {:ok, file} ->
        String.split(file, "\n")
          |> List.delete_at(-1) # remove last item (empty line)
    end
  end

  @doc """
  error case for the table drawing
  """
  def print_table(:error) do
    puts "Error: No table to print"
  end

  @doc """
  print out a table based on the contents
  """
  def print_table(rows) do
    header = ["Last,First,Salary"]
    cell_length = find_longest_value(header ++ rows)
      |> String.length

    List.first(header)
      |> String.split(",")
      |> Enum.map(fn item -> cell(item, cell_length) end)
      |> Enum.join(" | ")
      |> puts

    Enum.map(Range.new(1, cell_length * 3 + 6), fn _ -> "-" end)
      |> Enum.join
      |> puts

    Enum.each(rows, fn row ->
      String.split(row, ",")
      |> Enum.map(fn item -> cell(item, cell_length) end)
      |> Enum.join(" | ")
      |> puts
    end)
  end

  defp cell(value, cell_length) do
    if String.length(value) != cell_length do
      cell(value <> " ", cell_length)
    else
      value
    end
  end

  defp find_longest_value([], longest), do: longest

  defp find_longest_value([head | tail], longest) do
    if String.length(head) > String.length(longest) do
      find_longest_value(tail, head)
    else
      find_longest_value(tail, longest)
    end
  end

  defp find_longest_value(list) do
    Enum.map(list, fn row -> String.split(row, ",") end)
      |> List.flatten
      |> find_longest_value("")
  end
end

DataParser.read("files/data.csv")
  |> DataParser.print_table
