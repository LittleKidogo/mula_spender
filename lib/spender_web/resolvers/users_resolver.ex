defmodule SpenderWeb.UserResolver do
  alias Spender.{Accounts, Accounts.User}

  def all_users(_root, _args, _info) do
    users = Accounts.list_users
    {:ok, users}
  end

  def create_user(_root, args, _info) do
    with {:ok, %User{} = user} <- Accounts.create_user(args) do
      {:ok, user}
    end
  end
end
