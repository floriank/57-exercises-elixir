defmodule WeatherGrab do
  @moduledoc """
  A module to grabs the weather via the OpenWeatherMap for a given location
  """

  import IO, only: [gets: 1, puts: 1]

  @api_url "http://api.openweathermap.org/data/2.5/weather"
  @api_key System.get_env("OWM_KEY")

  def prompt do
    gets("Enter a location! ") |> String.rstrip
  end

  def display_weather(location) do
    data = call(location)
    case data["cod"] do
      200 -> display(data)
      _ -> puts "Could not fetch feather data for #{location}"
    end
  end

  defp display(data) do
    puts "#{data["name"]} weather:"
    puts "Temperature: #{data["main"]["temp"]} degrees celsius"
  end

  defp callable_api(location) do
    "#{@api_url}?q=#{location}&appid=#{@api_key}&units=metric"
  end

  defp call(location) do
    response = callable_api(location)
      |> HTTPotion.get
    Poison.Parser.parse! response.body
  end
end

WeatherGrab.prompt
  |> WeatherGrab.display_weather
