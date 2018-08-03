defmodule SpenderWeb.Resolvers.WishList do
  alias Spender.{WishList, MoneyLogs}

  def get_items(_,%{input: params},_) do
    with {:ok, moneylog} <- MoneyLogs.get_moneylog(params.moneylog_id),
      {:ok, items} <- WishList.list_items(moneylog) do
        {:ok, items}
      end
  end

  def create_item(_,%{input: params}, _) do
    with {:ok, moneylog} <- MoneyLogs.get_moneylog(params.moneylog_id),
      {:ok, item} <- WishList.add_item(moneylog, params) do
      {:ok, item}
    end
  end

  def update_item(_,%{input: params}, _) do
    with {:ok, item} <- WishList.get_item(params.id),
     {:ok, updated_item} <- WishList.update_item(item, params) do
       {:ok, updated_item}
     end
  end

  def delete_item(_, %{input: params}, _) do
    with {:ok, item} <- WishList.get_item(params.id),
    {:ok, deleted_item} <- WishList.delete_item(item) do
      {:ok, deleted_item}
    end
  end
end
