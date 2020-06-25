defmodule PhoenixBlog.Post do
  use Ecto.Schema
  import Ecto.{
    Changeset,
    Query
  }

  schema "posts" do
    field :content, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :title])
    |> validate_required([:content, :title])
  end

  def ordered(query) do
    query
    |> order_by([desc: :inserted_at])
  end
end
