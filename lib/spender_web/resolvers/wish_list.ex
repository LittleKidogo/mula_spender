defmodule SpenderWeb.Resolvers.WishList do
  alias Spender.{WishList, WishList.Item, MoneyLogs}

  def get_items(_,%{input: params},_) do
    with {:ok, budget} <- MoneyLogs.get_budget(params.budget_id),
      {:ok, items} <- WishList.list_items(budget) do
        {:ok, items}
      end
  end

  def create_item(_,%{input: params}, _) do
    with {:ok, budget} <- MoneyLogs.get_budget(params.budget_id),
      {:ok, item} <- WishList.add_item(budget, params) do
      {:ok, item}
    end
  end

  def update_item(_,%{input: params}, _) do
    with {:ok, item} <- WishList.get_item(params.id),
     {:ok, updated_item} <- WishList.update_item(item, params) do
       {:ok, updated_item}
     end
  end
end
