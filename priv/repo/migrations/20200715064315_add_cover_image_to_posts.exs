defmodule PhoenixBlog.Repo.Migrations.AddCoverImageToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :cover_image, :string
    end
  end
end
