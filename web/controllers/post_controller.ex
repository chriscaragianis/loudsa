defmodule Loudsa.PostController do
  use Loudsa.Web, :controller
  alias Loudsa.Post

  def index(conn, _params) do
    posts = Repo.all(Post)

    json conn, posts
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get(Post, String.to_integer(id))

    json conn, post
  end
end
