defmodule PhoenixBlog.BlogTest do
  use PhoenixBlog.DataCase
  use Timex

  alias PhoenixBlog.Blog
  describe "posts" do
    alias PhoenixBlog.Blog.Post

    @valid_attrs %{
      "content" => "some content",
      "title" => "some title",
      "is_published" => true,
      "published_at" => Timex.now()
    }
    @update_attrs %{"content" => "some updated content", "title" => "some updated title"}
    @invalid_attrs %{"content" => nil, "title" => nil}


    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    # TODO: Test for ordering and draft posts.

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.slug) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.title == "some title"
      assert post.is_published == true
      assert post.slug == "some-title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.title == "some updated title"
      assert post.slug == "some-updated-title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.slug)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, post} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.slug) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
