defmodule SpenderWeb.Resolvers.User do
  alias Spender.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end
  
  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end
end
