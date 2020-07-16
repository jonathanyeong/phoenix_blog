defmodule PhoenixBlogWeb.PostController do
  use PhoenixBlogWeb, :controller
  import Phoenix.HTML.Link

  alias PhoenixBlog.Blog
  alias PhoenixBlog.Blog.Post

  def index(conn, _params) do
    posts = Blog.list_posts()
    ogtags = %{
      "og:type": "website",
      "og:site_name": "Jonathan Yeong",
      "og:title": "Jonathan Yeong Site"
    }
    render(conn, "index.html", posts: posts, ogtags: ogtags)
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params} = _params) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, ["Saved Post! ", link("Preview", to: Routes.post_path(conn, :show, post))])
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, ["Failed to create post. ", readable_errors(changeset.errors)])
        |> render(:new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id} = _params) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", changeset: changeset, post: post)
  end

  def update(conn, %{"post" => post_params, "id" => id} = _params) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post, post_params)
    case Blog.update_post(post, post_params) do
      {:ok, _log} ->
        conn
        |> put_flash(:info, ["Updated Post! ", link("Preview", to: Routes.post_path(conn, :show, post))])
        |> render(:edit, changeset: changeset, post: post)
      {:error, changeset} ->
        conn
        |> put_flash(:error, ["Failed to update post. ", readable_errors(changeset.errors)])
        |> render(:edit, changeset: changeset, post: post)
    end
  end

  def show(conn, %{"id" => id} = _params) do
    post = Blog.get_post!(id)
    current_admin = conn.assigns[:current_admin]
    ogtags = %{
      "og:type": "article",
      "og:site_name": "Jonathan Yeong",
      "og:title": post.title,
      "og:description": post.content || post.title
    }
    if post.is_published || current_admin do
      render(conn, "show.html", post: post, ogtags: ogtags)
    else
      conn
      |> put_flash(:error, "No post found")
      |> redirect(to: "/posts")
    end
  end

  defp readable_errors(errors) do
    Enum.map(errors, fn item ->
      "#{elem(item, 0)} #{elem(item, 1) |> elem(0)} " end)
  end
end
