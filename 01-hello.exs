defmodule Hello do
  import IO, only: [{:puts, 1}, {:gets, 1}]
  @question "What is your name? \n"

  def greet(name) do
    stripped_name = String.rstrip(name) # remove trailing line break
    puts("Hello, " <> stripped_name <> ", nice to meet you!")
  end

  def ask do
    gets(@question)
  end
end

Hello.ask |> Hello.greet
