defmodule Spender.WishList do
  @moduledoc """
  This module is used for crud functions on WishList items
  """
  import Ecto.Query, warn: false
  alias Spender.Repo
  alias Ecto.Changeset

  alias Spender.{
    MoneyLogs,
    MoneyLogs.Moneylog,
    WishList.Item
  }

  @doc """
  Lists all wishlist items in a moneylog
  """
  @spec list_items(Moneylog.t)::{:ok, list(Item.t)} | {:error, String.t()}
  def list_items(%{id: id, name: name} = _moneylog) do
    query = from i in Item, where: i.moneylog_id == ^id

    with [_|_] = items <- Repo.all(query) do
      {:ok, items}
    else
      [] -> {:error, "#{name} doesn't have any items"}
    end
  end

  @doc """
  Adds a wishlist item to a moneylog and upates the moneylog to planning if neccessary
  """
  @spec  add_item(Moneylog.t, map) :: {:ok, Item.t} | {:error, Changeset.t()}
  def add_item(%{status: status} = moneylog, attrs) do
    case status do
      "new" ->
        {:ok, updated_moneylog} = moneylog |> MoneyLogs.update_moneylog(%{status: "planning"})
        do_add_item(updated_moneylog, attrs)
        _ -> do_add_item(moneylog, attrs)
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
  defp do_add_item(moneylog, attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Changeset.put_assoc(:moneylog, moneylog)
    |> Repo.insert()
  end
end
