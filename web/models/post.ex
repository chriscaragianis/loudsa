defmodule Loudsa.Post do
  use Loudsa.Web, :model

  schema "posts" do
    field :title, :string
    field :author, :string
    field :content, :string

    timestamps
  end
end
