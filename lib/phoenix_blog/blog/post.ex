defmodule PhoenixBlog.Blog.Post do
  use Ecto.Schema
  import Ecto.{
    Changeset,
    Query
  }
  import EctoEnum

  @derive {Phoenix.Param, key: :slug}
  defenum TypeEnum, post: 0, page: 1

  schema "posts" do
    field :content, :string
    field :title, :string
    field :is_published, :boolean
    field :slug, :string, unique: true
    field :published_at, :utc_datetime
    field :type, TypeEnum
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    attrs = Map.merge(attrs, slug_map(attrs))
    post
    |> cast(attrs, [:content, :title, :is_published, :slug, :published_at, :type])
    |> validate_required([:content, :title, :is_published, :published_at])
  end

  def ordered(query) do
    query
    |> order_by([desc: :inserted_at])
  end

  def published(query) do
    query
    |> where(is_published: true)
  end

  defp slug_map(%{"title" => title}) do
    slug = String.downcase("#{title}") # Using string interpolation to handle the nil case
           |> String.replace(~r/[^a-z0-9\s-]/, "")
           |> String.replace(~r/(\s|-)+/, "-")
    %{"slug" => slug}
  end

  # To handle the new route
  defp slug_map(_params) do
    %{}
  end
end
