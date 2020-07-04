defmodule PhoenixBlogWeb.AdminDashboardController do
  use PhoenixBlogWeb, :controller

  alias PhoenixBlog.{
    Blog,
    Repo
  }

  def index(conn, _params) do
    posts = Blog.list_all_posts()
    render(conn, "index.html", posts: posts)
  end
end
