defmodule PhoenixBlogWeb.PageController do
  use PhoenixBlogWeb, :controller

  def about(conn, _params) do
    render(conn, "about.html")
  end
end