defmodule PhoenixBlogWeb.PostView do
  use PhoenixBlogWeb, :view

  def as_html(txt) do
    txt
    |> Earmark.as_html!
    |> raw
  end

  def current_datetime(admin) do
    DateTime.now!(admin.timezone || "Etc/UTC")
  end
end
