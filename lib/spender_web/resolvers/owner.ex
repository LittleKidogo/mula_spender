defmodule SpenderWeb.Resolvers.Owner do
  alias Spender.{MoneyLogs, MoneyLogs.Owner}

  def get_owner(_, _, %{context: context}) do
    with {:ok, %Owner{} = owner} <- MoneyLogs.get_owner(context[:current_user]) do
      {:ok, owner}
    end
  end

  def get_budgets(_,_,%{context: context}) do
   with {:ok, owner} <- MoneyLogs.get_owner(context[:current_user]),
      {:ok, budgets} <- MoneyLogs.list_budgets(owner) do
      {:ok, budgets}
   end
  end

  def create_budget(_,%{input: args},%{context: context}) do
    with {:ok, owner} <- MoneyLogs.fetch_or_create_owner(context[:current_user]),
      {:ok, budget} <- MoneyLogs.create_budget(owner, args) do
        {:ok, budget}
      end
  end

  def update_budget(_,%{input: args}, _) do
    with {:ok, budget} <- MoneyLogs.get_budget(args.id),
      {:ok, updated_budget} <- MoneyLogs.update_budget(budget, args) do
        {:ok, updated_budget}
    end
  end

  def delete_budget(_,%{input: args},_) do
    with {:ok, budget} <- MoneyLogs.get_budget(args.id),
      {:ok, deleted_budget} <- MoneyLogs.delete_budget(budget) do
        {:ok, deleted_budget}
      end
  end
end
