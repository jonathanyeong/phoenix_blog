defmodule PhoenixBlogWeb.PostView do
  use PhoenixBlogWeb, :view

  def as_html(txt) do
    options = %Earmark.Options{
      code_class_prefix: "lang-",
      smartypants: false
    }
    txt
    |> Earmark.as_html!(options)
    |> raw
  end

  def current_datetime(admin) do
    Timex.now(admin.timezone || "Etc/UTC")
  end

  def post_display_date(datetime) do
    Timex.format!(datetime, "%b %d, %Y", :strftime)
  end
end
