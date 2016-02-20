defmodule ValidatingPasswords do
  @doc """
  A simple password validator to test if/else conditions
  """

  import String, only: [rstrip: 1]
  import IO, only: [gets: 1, puts: 1]

  @valid_password  "12345"

  def ask do
    gets("What's the password? ")
      |> rstrip
  end

  def validate(@valid_password) do
    puts "Welcome!"
  end

  def validate(_) do
    puts "I don't know you."
  end
end

ValidatingPasswords.ask
  |> ValidatingPasswords.validate
