defmodule Loudsa.PostController do
  use Loudsa.Web, :controller
  alias Loudsa.Post

  def index(conn, _params) do
    posts = [
      %Post{
        id: 1,
        title: "Post example 1",
        author: "Example Author",
        content: "Some <em>nice</em> html content"
      }
    ]
    json conn, posts
  end
end
