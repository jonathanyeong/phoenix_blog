defmodule PhoenixBlogWeb.AdminDashboardController do
  use PhoenixBlogWeb, :controller

  alias PhoenixBlog.{
    Post,
    Repo
  }

  def index(conn, _params) do
    posts =
      Post
      |> Post.ordered()
      |> Repo.all()
    render(conn, "index.html", posts: posts)
  end
end
