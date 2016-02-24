defmodule ValidatingInput do
  @moduledoc """
  a module to test validation functions on some inputs
  """
  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]

  @min_length_name 3
  @employee_id_format ~r(^[a-zA-Z]{2}\-\d{4}$)
  @doc """
  ask the user for input
  """
  def ask do
    first_name = question("What is your first name?")
    last_name  = question("What is your last name?")
    zip_code   = question("Enter a zip code!")
    id         = question("Enter your employee id!")

    # validate each property
    %{
      first_name: valid_first,
      last_name:  valid_last,
      zip:        valid_zip,
      id:         valid_id
    }
    = validate(%{
        first_name: first_name,
        last_name: last_name,
        zip: zip_code,
        id: id
      })

    ask_again = false
    unless valid_first do
      ask_again = true
      puts "The first name is too short!"
    end

    unless valid_last do
      ask_again = true
      puts "The last name  is too short!"
    end

    unless valid_zip do
      ask_again = true
      puts "The zip code \"#{zip_code}\" is invalid! Must be numbers only!"
    end

    unless valid_id do
      ask_again = true
      puts "The employee id \"#{id}\" seems to be invalid!"
    end

    if ask_again do
      puts "Try again:"
      ask
    end

    puts "All good."
  end

  @doc """
  validates a given map of properties, essentially a convenience function around the different validations
  returns a map containing validity info on the fields
  """
  def validate(%{first_name: first_name, last_name: last_name, zip: zip_code, id: id}) do
    %{
      first_name: valid_name(first_name),
      last_name: valid_name(last_name),
      zip: valid_zip(zip_code),
      id: valid_id(id)
    }
  end

  @doc """
  validates a given name

  NOTE: the book is not clear here where it states that the name must be filled in but the example shows
  it's necessary to validate a certain length
  """
  def valid_name(name) do
    String.length(name) >= @min_length_name
  end

  @doc """
  validates a given zip code

  basically checks whether this is numeric or not
  """
  def valid_zip(code) do
    case Float.parse(code) do
      {_, ""} -> true # number only
      _ -> # contains something different than a number
    end
  end

  @doc """
  validates a given employee id
  """
  def valid_id(id) do
    Regex.match?(@employee_id_format, id)
  end

  defp question(text) do
    gets(text <> " ")
      |> rstrip
  end
end

ValidatingInput.ask
