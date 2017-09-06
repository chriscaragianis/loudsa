defmodule Loudsa.PageController do
  use Loudsa.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
