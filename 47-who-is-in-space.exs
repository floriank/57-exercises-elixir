defmodule SpaceStatus do
  @moduledoc """
  a module that displays the people that are currently in space
  """

  @api "http://api.open-notify.org/astros.json"

  import IO, only: [puts: 1]

  @doc """
  calls the api, then prints the table
  """
  def display do
    call |> print_table
  end

  defp print_table(data) do
    number = data["number"]
    people = data["people"]
    cell_length = Enum.map(people, fn person -> person["name"] end)
      |> find_longest_name
    puts "There are currently #{number} #{person_identifer(number)} in space:"

    Enum.map(~w(Name Craft), fn item -> cell(item, cell_length) end)
      |> Enum.join(" | ")
      |> puts

    Enum.map(Range.new(1, cell_length * 2 + 3), fn _ -> "-" end)
      |> Enum.join
      |> puts

    Enum.each(people, fn person ->
      [cell(person["name"], cell_length), cell(person["craft"], cell_length)]
      |> Enum.join(" | ")
      |> puts
    end)
  end

  defp find_longest_name(names, longest \\ 0)

  defp find_longest_name([], longest), do: longest

  defp find_longest_name([head | tail], longest) do
    longest = cond do
      String.length(head) >= longest -> String.length(head)
      true -> longest
    end
    find_longest_name tail, longest
  end

  defp cell(value, length) do
    if String.length(value) == length do
      value
    else
      cell(value <> " ", length)
    end
  end

  defp call do
    response = HTTPotion.get(@api)
    Poison.Parser.parse! response.body
  end

  defp person_identifer(number) do
    if number == 1 do
      "person"
    else
      "people"
    end
  end
end

SpaceStatus.display
