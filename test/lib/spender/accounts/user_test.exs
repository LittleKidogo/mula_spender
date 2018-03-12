defmodule Spender.Accounts.UserTest do
  use Spender.DataCase
  alias Spender.Accounts.User


  @valid_attrs %{email: "someemail", provider: "someprovider", token: "sometoken"}
  @invalid_attrs %{email: "", provider: "", token: ""}

  describe "user changesets" do
    test " valid with correct attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "invalith with wrong attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
