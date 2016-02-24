defmodule PickingWinner do
  @moduledoc """
  a module to fill a given list with inputs an picking a random element from the list
  """

  import String, only: [rstrip: 1]
  import IO, only: [gets: 1, puts: 1]

  @doc """
  ask for contestants
  """
  def ask do
    contestants = gets("How many contestants are there? ")
      |> Integer.parse

    case contestants do
      :error ->
        puts "Not a number! try again"
        ask
      {0, _ } ->
        puts "Not a valid number"
        ask
      {number, _} ->
        ask_contestants(abs(number))
    end
  end

  def pick(list) do
    :random.seed(:os.timestamp)
    Enum.random(list)
  end

  defp ask_contestants(count, acc \\ [], times_called \\ 1)

  defp ask_contestants(0, acc, _), do: acc

  defp ask_contestants(count, acc, times_called) do
    contestant = gets("What is the name of contestant ##{times_called}? ")
      |> rstrip
    if count > 0 do
      ask_contestants(count - 1, acc ++ [contestant], times_called + 1)
    end
  end
end

winner = PickingWinner.ask |> PickingWinner.pick
IO.puts "Winner is #{winner}"
