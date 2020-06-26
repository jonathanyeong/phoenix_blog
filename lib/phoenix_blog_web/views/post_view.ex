defmodule PhoenixBlogWeb.PostView do
  use PhoenixBlogWeb, :view

  def as_html(txt) do
    txt
    |> Earmark.as_html!
    |> raw
  end
end
