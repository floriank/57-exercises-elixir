defmodule LegalDrivingAge do
  @doc """
  decides if a user is old enough to drive yet based on the age they input
  """

  import String, only: [rstrip: 1]
  import IO, only: [puts: 1 , gets: 1]

  @legal_driving_age 18 # we're not in the US

  def ask_age do
    gets("How old are you? ")
      |> rstrip
      |> Integer.parse
  end

  @doc """
  function call if the age is not parsed correctly
  """
  def legal?(:error) do
    puts "That is not a valid age! Try again!"
    ask_age |> legal?
  end

  @doc """
  function call for valid age
  """
  def legal?({age, _}) do
    if age >= 18, do: puts("You may drive!"), else: puts("You are not allowed to drive!")
  end
end

LegalDrivingAge.ask_age
  |> LegalDrivingAge.legal?
