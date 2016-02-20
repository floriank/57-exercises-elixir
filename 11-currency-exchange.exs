defmodule CurrencyExchange do
  @doc """
  A module to do currency exchange between EUR and USD
  """

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1, downcase: 1]
  import Float, only: [parse: 1]

  @api_url "http://openexchangerates.org/api/latest.json"
  @api_key "026c3b0dc4e64518902fef18399d4bbf"

  @doc """
  Ask the user if they want to use the API and then delegate to ask_values
  """
  def ask do
    answer = gets("Do you want the API for conversion (\"y\" or \"yes\" for yes)? ")
      |> rstrip
      |> downcase
    cond do
      answer == "y" || answer == "yes" -> ask_values
      true -> ask_values(true)
    end
  end


  @doc """
  calculate the amount of euros using the exchange rate given, or call the API
  """
  def calculate({euros, rate, asked_rate}) do
    if asked_rate == true do
      # assume local
      {euros * rate, euros, rate}
    else
      # assume using api
      call_api(euros)
    end
  end

  @doc """
  output the conversion
  """
  def print_result({amount, euros, rate}) do
    puts "At a rate of #{rate} EUR per USD, #{euros} EUR would be: #{Float.round(amount, 2)} USD"
  end

  defp call_api(euros) do
    :inets.start
    {:ok, response} = :httpc.request(:get, {callable_api_url, []}, [], [])
    { _, _, body } = response
    {0,euros,0}
  end

  defp callable_api_url do
    String.to_char_list "#{@api_url}?app_id=#{@api_key}"
  end

  defp ask_values(ask_rate \\ false) do
    euros = gets("How many euros do you have? ")
      |> rstrip
      |> parse
    if euros == :error do
      puts "Please input a number!"
      ask_values(ask_rate)
    else
      { euros, _ } = euros
      rate = 0
      if ask_rate == true do
        { rate, _ } = gets("What is the exchange_rate? ")
          |> rstrip
          |> parse
      end
      {euros, rate, ask_rate}
    end
  end
end

CurrencyExchange.ask
  |> CurrencyExchange.calculate
  |> CurrencyExchange.print_result
