defmodule PhoenixBlogWeb.RssController do
  use PhoenixBlogWeb, :controller
  plug :put_layout, false
  alias PhoenixBlog.Blog

  def index(conn, _params) do
    posts = Blog.list_posts()
    conn
    |> put_resp_content_type("text/xml")
    |> render("index.xml", posts: posts)
  end
end