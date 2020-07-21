defmodule PhoenixBlogWeb.Helpers.SharedHelpers do
  use Phoenix.HTML

  def md_to_html(txt) do
    options = %Earmark.Options{
      code_class_prefix: "lang-",
      smartypants: false
    }
    txt
    |> Earmark.as_html!(options)
    |> raw
  end
end