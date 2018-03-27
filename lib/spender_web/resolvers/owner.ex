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
end
