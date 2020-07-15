defmodule PhoenixBlogWeb.SitemapView do
  use PhoenixBlogWeb, :view

  def format_date(datetime) do
    Timex.format!(datetime, "%Y-%m-%d", :strftime)
  end
end
