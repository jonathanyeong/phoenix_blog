defmodule PhoenixBlog.PostTest do
  use PhoenixBlog.DataCase

  alias PhoenixBlog.Blog.Post

  describe "#slugify_title" do
    test "Turns the title into a slug" do
      title = "Hacking Your Shower!!!"
      result = "hacking-your-shower"
      assert Post.slugify(title) == result

      title = "Hi you're a shower!!!"
      result = "hi-youre-a-shower"
      assert Post.slugify(title) == result
    end
  end

end