defmodule Loudsa.Router do
  use Loudsa.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, [origin: "http://localhost:3000"]
  end

  scope "/", Loudsa do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/swag", PageController, :index
    get "/news", PageController, :index
    get "/blog", PageController, :index
    get "/bylaws", PageController, :index
    get "/about", PageController, :index
    get "/calendar", PageController, :index
  end

  scope "/api/v1", Loudsa do
    pipe_through :api

    get "/posts", PostController, :index
    get "/posts/:id", PostController, :show
    get "/swags", SwagController, :index
    get "/events", EventController, :index
    get "/events/:id", EventController, :show
    post "/users", UserController, :create
    post "/sessions", SessionController, :create
    post "/charge", ChargeController, :create
    options "/charge", ChargeController, :options
    post "/email", EmailController, :create
    options "/email", EmailController, :options
  end

  # Other scopes may use custom stacks.
  # scope "/api", Loudsa do
  #   pipe_through :api
  # end
end
