defmodule FilterRecords do
  @moduledoc """
  A module to filter out records of a given dataset based on a query string
  """

  import IO, only: [gets: 1, puts: 1]

  def search_by(data) do
    search_for = question("Enter a search string:")
    Enum.filter data, fn(person) ->
      first    = String.downcase person.firstname
      last     = String.downcase person.lastname
      position = String.downcase person.position

      String.contains?(first, search_for) ||
        String.contains?(last, search_for) ||
          String.contains?(position, search_for)
    end
  end

  @doc """
  print out a table (taken from exercise 39)
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

  defp question(text) do
    gets(text <> " ")
      |> String.rstrip
      |> String.downcase
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

FilterRecords.search_by(data)
  |> FilterRecords.print_table
