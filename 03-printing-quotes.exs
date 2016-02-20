defmodule PrintingQuotes do
  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1]

  def ask_quote do
    gets("Whats is the quote? ")
  end

  def ask_author(saying) do
    %{ author: gets("Who said it? "), saying: saying }
  end

  def print_quote(%{ saying: saying, author: author }) do
    puts(rstrip(author) <> " says: " <> "\"" <> rstrip(saying) <> "\"")
  end
end

PrintingQuotes.ask_quote
  |> PrintingQuotes.ask_author
  |> PrintingQuotes.print_quote
