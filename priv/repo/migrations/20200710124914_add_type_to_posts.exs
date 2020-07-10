defmodule PhoenixBlog.Repo.Migrations.AddTypeToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :type, :integer, default: 0
    end
  end
end
