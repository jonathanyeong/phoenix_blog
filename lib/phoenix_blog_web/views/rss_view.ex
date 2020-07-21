defmodule PhoenixBlogWeb.RssView do
  use PhoenixBlogWeb, :view

  def format_date(datetime) do
    Timex.format!(datetime, "%a, %d %b %Y", :strftime)
  end

end
