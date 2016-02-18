defmodule RectangularRoom do
  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]
  import Float, only: [parse: 1]

  @conversion_factor 0.09290304

  def ask do
    length = gets("What is the length of the room in feet? ")
      |> rstrip
      |> parse
    width = gets("What is the width of the room in feet? ")
      |> rstrip
      |> parse

    case {length, width} do
      {:error, _} ->
        puts "Length is not a valid number! Please try again!"
        ask
      {_, :error } ->
        puts "Width is not a number! Please try again!"
        ask
      { { length, _ }, { width, _ } } -> { length, width }
    end
  end

  def print_input({length, width}) do
    puts "You entered dimensions " <> output_float(length) <> " feet by " <> output_float(width) <> " feet."
    puts "The area is:"
    {length, width}
  end

  def print_imperial({length, width}) do
    puts output_float(length * width) <> " square feet"
    {length, width}
  end

  def print_metric({length, width}) do
    mLength = convert(length)
    mWidth = convert(width)
    puts "That is about " <> output_float(mLength * mWidth) <> " square meters"
  end

  defp output_float(float) do
    Float.to_string(float, decimals: 3)
  end

  defp convert(imperial) do
    metric = :math.pow(imperial, 2) * @conversion_factor
    :math.sqrt(metric)
  end
end

RectangularRoom.ask
  |> RectangularRoom.print_input
  |> RectangularRoom.print_imperial
  |> RectangularRoom.print_metric
