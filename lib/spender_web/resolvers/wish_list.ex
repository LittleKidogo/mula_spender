defmodule SpenderWeb.Resolvers.WishList do
  alias Spender.{WishList, WishList.Item, MoneyLogs}

  def get_items(_,%{input: params},_) do
    with {:ok, budget} <- MoneyLogs.get_budget(params.budget_id),
      {:ok, items} <- WishList.list_items(budget) do
        {:ok, items}
      end
  end
end
