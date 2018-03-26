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
  def list_items(%{id: id} = _budget) do
    query = from i in Item, where: i.budget_id == ^id

    Repo.all(query)
  end

  @doc """
  Adds a wishlist item to a budget and upates the budget to planning if neccessary
  """
  @spec  add_item(Budget.t, map) :: {:ok, Item.t} | {:error, Changeset.t()}
  def add_item(%{id: id, status: status} = budget, attrs) do
    case status do
      "new" ->
        {ok, updated_budget} = budget |> MoneyLogs.update_budget(%{status: "planning"})
        do_add_item(updated_budget, attrs)
        _ -> do_add_item(budget, attrs)
    end
  end

  @doc false
  defp do_add_item(budget, attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Changeset.put_assoc(:budget, budget)
    |> Repo.insert()
  end
end
