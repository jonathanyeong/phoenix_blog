defmodule PhoenixBlog.Repo.Migrations.AddTimezoneToUser do
  use Ecto.Migration

  def change do
    alter table("admins") do
      add :timezone, :string
    end
  end
end
