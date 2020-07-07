defmodule PhoenixBlog.Repo.Migrations.AddPublishedAtToPost do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :published_at, :timestamptz
    end
  end
end
