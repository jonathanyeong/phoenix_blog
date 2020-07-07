defmodule PhoenixBlog.Blog.Post do
  use Ecto.Schema
  import Ecto.{
    Changeset,
    Query
  }

  @derive {Phoenix.Param, key: :slug}

  schema "posts" do
    field :content, :string
    field :title, :string
    field :is_published, :boolean
    field :slug, :string, unique: true
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    attrs = Map.merge(attrs, slug_map(attrs))
    post
    |> cast(attrs, [:content, :title, :is_published, :slug])
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