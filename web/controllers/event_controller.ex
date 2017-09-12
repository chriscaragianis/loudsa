defmodule Loudsa.EventController do
  use Loudsa.Web, :controller
  alias Loudsa.Event

  def index(conn, _params) do
    events = Repo.all(Event)

    json conn, events
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get(Event, String.to_integer(id))

    json conn, post
  end
end
