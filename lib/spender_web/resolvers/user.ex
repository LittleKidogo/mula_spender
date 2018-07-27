defmodule SpenderWeb.Resolvers.User do
  alias Spender.{Accounts, Accounts.User}

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def user(_, %{id: id}, _) do
    with {:ok, %User{} = user} <- Accounts.get_user(id) do
      {:ok, user}
    end
  end

  def update_user(_, %{input: params}, %{context: context}) do
    with {:ok, %User{} = user} <- Accounts.update_user(context[:current_user],params) do
      {:ok, user}
    end
  end
end
