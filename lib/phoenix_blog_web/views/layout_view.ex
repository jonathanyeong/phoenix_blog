defmodule PhoenixBlogWeb.LayoutView do
  use PhoenixBlogWeb, :view

  def ogtags(assigns) do
    if assigns[:ogtags] do
      for {key, value} <- assigns[:ogtags] do
          raw("<meta property=\"#{key}\" content=\"#{value}\" />")
      end
    else
      # Default OG tags
      raw("\t\n")
    end
  end
end
