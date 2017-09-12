defmodule Loudsa.PostTest do
  use Loudsa.ModelCase

  alias Loudsa.Post

  @valid_post %{
    id: "1",
    title: "Title",
    author: "Author",
    content: "html content",
  }

  test "can get all posts" do
    Repo.insert(@valid_post)
    assert length(Repo.all(Post)) == 1
  end
end
