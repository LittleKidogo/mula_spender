defmodule SpenderWeb.UserResolver do
  @moduledoc """
  This resolver returns the data for the requested user fields
  """
  alias Spender.{Accounts, Accounts.User}

  def all_users(_root, _args, _info) do
    users = Accounts.list_users
    {:ok, users}
  end

  def find_user(_parent, %{email: email}, _resolution) do
    with user <- Accounts.get_by_email(email) do
      {:ok, user}
    end
  end

  def create_user(_root, args, _info) do
    with {:ok, %User{} = user} <- Accounts.create_user(args) do
      {:ok, user}
    end
  end
end
