defmodule Loudsa.UserTest do
  use Loudsa.ModelCase

  alias Loudsa.User

  @valid_attrs %{email: "rosa@luxemburg.com", password: "secret"}
  @invalid_attrs %{email: "rosa@luxemburg.com", password: "ecret"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset, email too short" do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :email, "a")
    )
    refute changeset.valid?
  end

  test "changeset, email invalid format" do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :email, "rosa.com")
    )
  end

  test "registration_changeset, password not too short" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.changes.password_hash
    assert changeset.valid?
  end

  test "registration_changeset, password too short" do
    changeset = User.registration_changeset(
      %User{}, @invalid_attrs
    )
    refute changeset.valid?
  end
end

