defmodule PhoenixBlog.Repo.Migrations.AddIsPublishedToPost do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :is_published, :boolean
    end
  end
end
