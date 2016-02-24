defmodule EmployeeList do
  @doc """
  a module for demoing the removal of an item from a list
  """
  @list [
    "Tom Jane",
    "Wayne Gretzy",
    "Bruce Banner",
    "Ryan Reynolds",
    "Selina Kyle"
  ]

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1, downcase: 1, slice: 3, replace: 3]

  @doc """
  public access for the entry loop
  """
  def ask(list \\ @list) do
    if length(list) > 0 do
      puts "#{length(list)} employees total"
      Enum.each(list, &puts/1)
      name = gets("What is the name you'd wish to remove? ")
      case remove(name, list) do
        {:ok, list} ->
          puts "OK (#{length(list)} employees):"
          Enum.each(list, &puts/1)
          another = gets("Do you wish to remove another name? ")
            |> rstrip
            |> downcase
            |> slice(0, 1)
          if another == "y" do
            ask(list)
          end
        {:error, list} ->
          puts "Name was not found! Try again!"
          ask(list)
      end
    else
      puts "List is empty. Done."
    end
  end

  @doc """
  removes a given name from the current list
  """
  def remove(name, list) do
    downcased = Enum.map(list, &sanitize/1)
    name = sanitize(name)
    cond do
      name in downcased ->
        index = Enum.find_index(downcased, fn(item) -> item == name end)
        {:ok, List.delete_at(list, index)}
      true ->
        {:error, list}
    end
  end

  defp sanitize(name) do
    name
      |> rstrip
      |> downcase
      |> replace(" ", "")
  end
end

EmployeeList.ask
