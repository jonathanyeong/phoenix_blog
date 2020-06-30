defmodule PhoenixBlogWeb.PostController do
  use PhoenixBlogWeb, :controller

  alias PhoenixBlog.{
    Post,
    Repo
  }

  def index(conn, _params) do
    posts =
      Post
      |> Post.published()
      |> Post.ordered()
      |> Repo.all()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params} = _params) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, _log} ->
        conn
        |> put_flash(:info, "Success - created a Post!")
        |> redirect(to: Routes.post_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "failure couldn't create post")
        |> render(:new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id} = _params) do
    post = Repo.get!(Post, id)
    changeset =
      Post
      |> Repo.get!(id)
      |> Post.changeset(%{})
    render(conn, "edit.html", changeset: changeset, post: post)
  end

  def update(conn, %{"post" => post_params, "id" => id} = params) do
    post = Repo.get!(Post, String.to_integer(id))
    changeset = Post.changeset(post, post_params)
    case Repo.update(changeset) do
      {:ok, _log} ->
        conn
        |> put_flash(:info, "Success - created a Post!")
        |> render(:edit, changeset: changeset, post: post)
      {:error, changeset} ->
        conn
        |> put_flash(:error, "failure couldn't create post")
        |> render(:edit, changeset: changeset, post: post)
    end
  end
end
