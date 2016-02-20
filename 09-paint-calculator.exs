defmodule PaintCalculator do
  @doc """
  Caluclates the amount of paint needed to paint a certain surface

  Note: The exercise states imperial units. I am European and will use SI-units, instead of a gallon, I'll use the "bucket" as a placeholder as the amount of paint is irrelavent to the program, only how much surface it can cover
  """

  import String, only: [rstrip: 1]
  import IO, only: [gets: 1, puts: 1]
  import Integer, only: [parse: 1]

  @area_covered_by_single_bucket 100 # sqm

  @doc """
  Ask for the length and width of a room
  """
  def ask do
    length = question("How long is the room? ")
    width = question("How wide is the room? ")

    case {width, length} do
      {:error, _} ->
        puts "The width is not a number! Try again!"
        ask
      {_, :error} ->
        puts "The length is not a number! Try again!"
        ask
      { { width, _ }, { length, _ } } -> {length, width}
    end
  end

  @doc """
  Calculate the number of buckets needed for the rooms area
  """
  def calculate({length, width}) do
    area_to_cover = length * width
    buckets = div(area_to_cover, @area_covered_by_single_bucket)
    remainder = rem(area_to_cover, @area_covered_by_single_bucket)
    cond do
      remainder > 0 -> buckets + 1 # need one extra bucket if remaining area
      true -> buckets
    end
  end

  @doc """
  Print the result
  """
  def print(buckets) do
    if buckets == 1 do
      puts "You need one bucket to cover the room"
    else
      puts "You need #{buckets} buckets to cover the room!"
    end
  end

  defp question(sentence) do
    gets(sentence)
      |> rstrip
      |> parse
  end
end

PaintCalculator.ask
  |> PaintCalculator.calculate
  |> PaintCalculator.print
