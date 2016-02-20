defmodule MadLibs do
  import IO, only: [gets: 1, puts: 1]

  def ask(acc \\ [], atom) do
    acc ++ Keyword.put([], atom, gets("Enter " <> with_article(atom) <> " "))
  end

  def print_mad_lib(acc) do
    phrases = [
      "Do you",
      get_word(acc, :verb),
      "your",
      get_word(acc, :adjective),
      get_word(acc, :noun),
      get_word(acc, :adverb),
    ]
    str = Enum.join(phrases, " ")
    puts str <> "? That's hilarious!"
  end

  defp with_article(atom) do
    str = Atom.to_string(atom)
    if String.first(str) == "a" do
      "an " <> str
    else
      "a " <> str
    end
  end

  defp get_word(keywords, key) do
    if Keyword.has_key?(keywords, key) do
      String.rstrip(keywords[key])
    else
      ""
    end
  end
end

MadLibs.ask([], :noun)
  |> MadLibs.ask(:verb)
  |> MadLibs.ask(:adjective)
  |> MadLibs.ask(:adverb)
  |> MadLibs.print_mad_lib
