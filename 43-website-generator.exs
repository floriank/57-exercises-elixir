defmodule WebsiteGenerator do
  @moduledoc """
  a module to generate a folder structure

  NOTE: This will _always_ use the ./files/43-output path as the target folder prefix
  """

  @base "files/43-output"
  @index "index.html"

  @template """
  <!doctype html>
  <html>
    <head>
      <title>%{name}</title>
      <meta name="author" content="%{author}">
    </head>
    <body>
      <p>This is the index.</p>
    </body>
  </html>
  """

  import IO, only: [gets: 1, puts: 1]

  @doc """
  ask the user for some inputs
  """
  def ask do
    site_name = question("Site name?", String)
    author = question("Author:", String)
    js = question("Do you want a folder for JavaScript?", Boolean)
    css = question("Do you want a folder for CSS?", Boolean)

    %{name: site_name, author: author, js: js, css: css}
  end

  @doc """
  utility method to create everything at once
  """
  def generate(%{name: name, author: author, js: js, css: css}) do
    create_folder(name)
      |> create_index(author)

    puts "Created a new site at ./#{@base}/#{name}"
    puts "Created an index at ./#{@base}/#{name}/#{@base}"

    if js do
      create_js(name)
      puts "Created a folder for JS at ./#{@base}/#{name}/js"
    end

    if css do
      create_css(name)
      puts "Created a folder for CSS at ./#{@base}/#{name}/css"
    end
  end

  @doc """
  create the base folder, always prepends @base
  """
  def create_folder(name) do
    path = @base <> "/#{name}"
    case File.mkdir_p(path) do
      :ok -> path
      :error -> :error
    end
  end

  def create_index(path, author) do
    file = path <> "/#{@index}"
    case File.open(file, [:write]) do
      {:ok, device} ->
        IO.write device, template_html(author, path)
      {:error, reason} ->
        puts reason
    end
  end

  def create_js(name) do
    path = @base <> "/#{name}/js"
    File.mkdir(path)
  end

  def create_css(name) do
    path = @base <> "/#{name}/css"
    File.mkdir(path)
  end

  defp question(text, module)  do
    value = gets(text <> " ") |> String.rstrip

    case module do
      String -> value
      Boolean -> value == "yes" || value == "y"
    end
  end

  defp template_html(author, path) do
    name = Path.basename path
    String.replace(@template, "%{name}", name)
      |> String.replace("%{author}", author)
  end
end

WebsiteGenerator.ask
  |> WebsiteGenerator.generate
