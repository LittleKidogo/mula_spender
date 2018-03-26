defmodule Spender.WishListTest do
  use Spender.DataCase
  alias Spender.{WishList, MoneyLogs.Budget, WishList.Item}

  describe "WishList Context" do
    test "lists all the items that belong a budget (wishlist)" do
      budget = insert(:budget)
      insert_list(25, :wishlist_item, budget: budget)
      fetched_items = WishList.list_items(budget)
      assert Enum.count(fetched_items) == 25
    end

  end

end
