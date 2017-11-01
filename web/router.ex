defmodule Loudsa.Router do
  use Loudsa.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Loudsa do
    pipe_through :api
  end
end
