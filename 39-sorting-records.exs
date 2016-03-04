defmodule RecordSorting do
  @moduledoc """
  a module to sort a set of maps by a key
  """

  import IO, only: [gets: 1, puts: 1]

  @doc """
  sorts the given list by the key given
  """
  def sort_by(list, key, direction \\ :asc) do
    Enum.map(list, fn (item) -> item[key] || "" end)
      |> Enum.sort
      |> sort(list, key)
      |> reverse?(direction)
  end

  @doc """
  print out a table
  """
  def print_table(list) do
    puts " Name                        | Position                     | Separation date             "
    puts "=========================================================================================="
    Enum.each list, fn (person) ->
      puts "#{cell(person.firstname <> " " <> person.lastname)} | #{cell(person.position)} | #{cell(person[:separation_date] || "")}"
    end
  end

  defp cell(str) do
    # note: each cell (w/o divider is 28 long, 2 spaces to the side)
    remaining =  26 - String.length(str)
    spaces =  Enum.map(Range.new(1, remaining), fn(_) -> " " end)
      |> Enum.join
    " #{str}" <> spaces <> " "
  end

  defp reverse?(list, direction) do
    if direction == :asc do
      list
    else
      Enum.reverse(list)
    end
  end

  defp sort(arr, _, _, acc \\ [])

  defp sort([], _, _, acc), do: acc

  defp sort([head | tail], list, key, acc) do
    acc = acc ++ Enum.filter(list, fn (item) -> (item[key] || "") == head end)
    sort(tail, list, key, acc)
  end
end

data = [
  %{
    firstname: "John",
    lastname: "Johnson",
    position: "Manager",
    separation_date: "2016-12-31"
  },
  %{
    firstname: "Tou",
    lastname: "Xiong",
    position: "Software engineer",
    separation_date: "2016-10-05"
  },
  %{
    firstname: "Michaela",
    lastname: "Michaelson",
    position: "District Manager",
    separation_date: "2016-12-19"
  },
  %{
    firstname: "Jake",
    lastname: "Jacobson",
    position: "Programmer"
  },
  %{
    firstname: "Jacquelyn",
    lastname: "Jackson",
    position: "DBA"
  },
  %{
    firstname: "Sally",
    lastname: "Weber",
    position: "Web developer",
    separation_date: "2015-12-18"
  }
]

RecordSorting.sort_by(data, :lastname, :asc)
  |> RecordSorting.print_table
