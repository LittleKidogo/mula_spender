defmodule Spender.UserTest do
  #use model set up
  use Spender.ModelCase

  alias Spender.User

  @valid_user %{ name: "Zacck"}
  @invalid_user %{}
  describe "create_changeset/2" do
    test "with valid attributes" do
      changeset = User.create_changeset(%User{}, @valid_user)
      assert changeset.valid?
    end

    test "fails with invalid attributes" do
      changeset = User.create_changeset(%User{}, @invalid_user)
      refute changeset.valid?
    end
  end

  describe "update_changeset/2" do
    test "with valid attributes" do
      changeset = User.update_changeset(%User{}, %{name: @valid_user.name, id: 1, avatar: "string"})
      assert changeset.valid?
    end

    test "fails with invalid attributes" do
      changeset = User.update_changeset(%User{}, @valid_user)
      refute changeset.valid?
    end
  end

end
