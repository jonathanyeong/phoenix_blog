defmodule PhoenixBlogWeb.AdminDashboardView do
  use PhoenixBlogWeb, :view

  def as_html(txt) do
    txt
    |> Earmark.as_html!
    |> raw
  end

  def admin_display_date(datetime) do
    if datetime != nil do
      Timex.format!(datetime, "%d %b, %Y %I:%M%p", :strftime)
    end
  end
end
