defmodule Loudsa.UserController do
  use Loudsa.Web, :controller

  alias Loudsa.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> show(%{"id" => Kernel.inspect(user.id)})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Loudsa.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get(User, String.to_integer(id))
    json conn, post
  end
end
