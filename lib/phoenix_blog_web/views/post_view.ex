defmodule PhoenixBlogWeb.PostView do
  use PhoenixBlogWeb, :view

  def current_datetime(admin) do
    Timex.now(admin.timezone || "Etc/UTC")
  end

  def post_display_date(datetime) do
    Timex.format!(datetime, "%b %d, %Y", :strftime)
  end
end
