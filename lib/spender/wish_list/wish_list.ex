defmodule Spender.WishList do
  @moduledoc """
  This module is used for crud functions on WishList items
  """
  import Ecto.Query, warn: false
  alias Spender.Repo
  alias Ecto.Changeset

  alias Spender.{
    MoneyLogs,
    MoneyLogs.Budget,
    WishList.Item
  }

  @doc """
  Lists all wishlist items in a budget
  """
  @spec list_items(Budget.t)::list(Item.t)
  def list_items(%{id: id, name: name} = _budget) do
    query = from i in Item, where: i.budget_id == ^id

    with [_|_] = items <- Repo.all(query) do
      {:ok, items}
    else
      [] -> {:error, "#{name} doesn't have any items"}
    end
  end

  @doc """
  Adds a wishlist item to a budget and upates the budget to planning if neccessary
  """
  @spec  add_item(Budget.t, map) :: {:ok, Item.t} | {:error, Changeset.t()}
  def add_item(%{status: status} = budget, attrs) do
    case status do
      "new" ->
        {:ok, updated_budget} = budget |> MoneyLogs.update_budget(%{status: "planning"})
        do_add_item(updated_budget, attrs)
        _ -> do_add_item(budget, attrs)
    end
  end

  @doc """
  This functions takes n existing wishlist item and some update attributes and applies
  the updates to the item
  """
  @spec update_item(Item.t, map) :: {:ok, Item.t} | {:error, Changeset.t()}
  def update_item(item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @spec get_item(integer()) :: {:ok, Item.t} | {:error, String.t()}
  def get_item(id) do
    with %Item{} = item  <- Item |> Repo.get(id) do
      {:ok, item}
    else
      nil ->
        {:error, "wishlist item not found"}
    end
  end

  @doc """
  This deletes a wishlist item from the database
  """
  @spec delete_item(Item.t) :: {:ok, Item.t} | {:error, Ecto.Changeset.t()}
  def delete_item(%Item{} =  item) do
    Repo.delete(item)
  end

  @doc false
  defp do_add_item(budget, attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Changeset.put_assoc(:budget, budget)
    |> Repo.insert()
  end
end
