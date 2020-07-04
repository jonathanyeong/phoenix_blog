defmodule PhoenixBlog.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias PhoenixBlog.Repo

  alias PhoenixBlog.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do # TODO: This is a horrendous name. Too tired to think of one.
    Post
    |> Post.published()
    |> Post.ordered()
    |> Repo.all()
  end

  # TODO: Add doc string
  def list_all_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

  """
  def get_post!(id) do
    Repo.get!(Post, id)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, ...}

  """
  # This is pulled from the Post Controller. I'll be moving the Post controller logic into the Context.
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, ...}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, ...}

  """
  # TODO: I don't know how I want to handle deletes.
  # Do I archive, do I remove from the DB...
  def delete_post(%Post{} = post) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Todo{...}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs) # TODO: (REMOVE) we want to use attrs here because we want to render up to date changesets
  end
end
