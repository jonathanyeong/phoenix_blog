defmodule PhoenixBlog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :text
      add :title, :string

      timestamps()
    end

  end
end
