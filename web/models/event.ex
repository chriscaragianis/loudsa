defmodule Loudsa.Event do
  use Loudsa.Web, :model

  schema "events" do
    field :title, :string
    field :start, :utc_datetime
    field :end, :utc_datetime
    field :description, :string
    field :location, :string

    timestamps
  end
end
