defmodule PhoenixBlogWeb.RssView do
  use PhoenixBlogWeb, :view

  def format_date(datetime) do
    Timex.format!(datetime, "%a, %d %b %Y", :strftime)
  end

  def as_html(txt) do
    options = %Earmark.Options{
      code_class_prefix: "lang-",
      smartypants: false
    }
    txt
    |> Earmark.as_html!(options)
    |> raw
  end
end
