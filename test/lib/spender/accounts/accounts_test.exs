defmodule Spender.AccountsTest do
  use Spender.DataCase

  alias Spender.Accounts

  describe "users" do
    alias Spender.Accounts.User

    @valid_attrs %{email: "someemail", provider: "someprovider", token: "sometoken"}
    @update_attrs %{email: "someupdatedemail", provider: "someupdatedprovider", token: "someupdatedtoken"}
    @invalid_attrs %{email: "", provider: "", token: ""}


    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Accounts.get_user!(user.id) == user
    end

    test "get_by_email/1 returns the user with given email" do
      user = insert(:user)
      assert Accounts.get_by_email(user.email) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.provider == "someprovider"
      assert user.email == "someemail"
      assert user.token == "sometoken"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.provider == "someupdatedprovider"
      assert user.token == "someupdatedtoken"
      assert user.email == "someupdatedemail"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
