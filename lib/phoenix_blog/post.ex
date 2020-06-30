defmodule PhoenixBlog.Post do
  use Ecto.Schema
  import Ecto.{
    Changeset,
    Query
  }

  schema "posts" do
    field :content, :string
    field :title, :string
    field :is_published, :boolean

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :title, :is_published])
    |> validate_required([:content, :title, :is_published])
  end

  def ordered(query) do
    query
    |> order_by([desc: :inserted_at])
  end

  def published(query) do
    query
    |> where(is_published: true )
  end
end
