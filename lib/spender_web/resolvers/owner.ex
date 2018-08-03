defmodule SpenderWeb.Resolvers.Owner do
  alias Spender.{MoneyLogs, MoneyLogs.Owner}

  def get_owner(_, _, %{context: context}) do
    with {:ok, %Owner{} = owner} <- MoneyLogs.get_owner(context[:current_user]) do
      {:ok, owner}
    end
  end

  def get_moneylog(_,_,%{context: context}) do
   with {:ok, owner} <- MoneyLogs.get_owner(context[:current_user]),
      {:ok, moneylog} <- MoneyLogs.list_moneylog(owner) do
      {:ok, moneylog}
   end
  end

  def create_moneylog(_,%{input: args},%{context: context}) do
    with {:ok, owner} <- MoneyLogs.fetch_or_create_owner(context[:current_user]),
      {:ok, moneylog} <- MoneyLogs.create_moneylog(owner, args) do
        {:ok, moneylog}
      end
  end

  def update_moneylog(_,%{input: args}, _) do
    with {:ok, moneylog} <- MoneyLogs.get_moneylog(args.id),
      {:ok, updated_moneylog} <- MoneyLogs.update_moneylog(moneylog, args) do
        {:ok, updated_moneylog}
    end
  end

  def delete_moneylog(_,%{input: args},_) do
    with {:ok, moneylog} <- MoneyLogs.get_moneylog(args.id),
      {:ok, deleted_moneylog} <- MoneyLogs.delete_moneylog(moneylog) do
        {:ok, deleted_moneylog}
      end
  end
end
