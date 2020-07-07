defmodule PhoenixBlogWeb.PostController do
  use PhoenixBlogWeb, :controller

  alias PhoenixBlog.Blog
  alias PhoenixBlog.Blog.Post

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    admin = conn.assigns.current_admin
    render(conn, "new.html", changeset: changeset, admin: admin)
  end

  def create(conn, %{"post" => post_params} = _params) do
    case Blog.create_post(post_params) do
      {:ok, _log} ->
        conn
        |> put_flash(:info, "Success - created a Post!")
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "failure couldn't create post")
        |> render(:new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id} = _params) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    admin = conn.assigns.current_admin
    render(conn, "edit.html", changeset: changeset, post: post, admin: admin)
  end

  def update(conn, %{"post" => post_params, "id" => id} = _params) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post, post_params)
    case Blog.update_post(post, post_params) do
      {:ok, _log} ->
        conn
        |> put_flash(:info, "Success - Updated a Post!")
        |> render(:edit, changeset: changeset, post: post)
      {:error, changeset} ->
        conn
        |> put_flash(:error, "failure couldn't create post")
        |> render(:edit, changeset: changeset, post: post)
    end
  end

  def show(conn, %{"id" => id} = _params) do
    post = Blog.get_post!(id)
    render(conn, "show.html", post: post)
  end
end
