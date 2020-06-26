defmodule PhoenixBlogWeb.AdminDashboardController do
  use PhoenixBlogWeb, :controller

  # alias PhoenixBlog.Accounts
  # alias PhoenixBlog.Accounts.Admin
  # alias PhoenixBlogWeb.AdminAuth

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
