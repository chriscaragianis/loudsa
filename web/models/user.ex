defmodule Loudsa.User do
  use Loudsa.Web, :model

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email), [])
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/@/)
  end

  def registration_changeset(model, params \\ :empty) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6)
    |> put_password_hash
  end

  def put_password_hash(changeset) do
    case changeset do
      #%Ecto.Changeset{valid?: true,  changes: %{password: pass}} ->
        #put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(pass))
      _ -> changeset
    end
  end
end
