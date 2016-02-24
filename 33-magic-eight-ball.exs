defmodule MagicEightball do
  @moduledoc """
  a magic 8-Ball that gives you an answer to your question. Not really.
  """

  @answers [
    "Yes",
    "No",
    "Maybe",
    "Ask again later!"
  ]

  import IO, only: [gets: 1, puts: 1]

  @doc """
  shake!
  """
  def shake! do
    :random.seed(:os.timestamp)
    gets("What is your question? ")
    @answers
    |> Enum.random
    |> puts
  end
end

MagicEightball.shake!
