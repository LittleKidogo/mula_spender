defmodule Spender.WishListTest do
  use Spender.DataCase
  alias Spender.{WishList, MoneyLogs.Budget, WishList.Item}

  describe "WishList Context" do
    test "lists all the items that belong a budget (wishlist)" do
      budget = insert(:budget)
      insert_list(25, :wishlist_item, budget: budget)
      {:ok, fetched_items} = WishList.list_items(budget)
      assert Enum.count(fetched_items) == 25
    end

    test "add item should add an item and update a budgets status" do
      budget = insert(:budget)
      attrs = %{name: "Oats", price: 25.34}
      assert Repo.aggregate(Budget, :count, :id) == 1
      assert Repo.aggregate(Item, :count, :id) == 0
      {:ok, item} = WishList.add_item(budget, attrs)
      assert Repo.aggregate(Budget, :count, :id) == 1
      assert Repo.aggregate(Item, :count, :id) == 1
      saved_budget = Repo.one(Budget)
      assert item.budget_id == budget.id
      assert item.name == attrs.name
      assert saved_budget.id == budget.id
      assert saved_budget.status == "planning"
     end

     test "adds an item to budget in planning" do
       budget = insert(:budget)
       first_attrs = %{name: "Oats", price: 25.34}
       second_attrs = %{name: "Rice Flour", price: 15.00}
       assert Repo.aggregate(Budget, :count, :id) == 1
       assert Repo.aggregate(Item, :count, :id) == 0
       {:ok, _item} = WishList.add_item(budget, first_attrs)
       assert Repo.aggregate(Budget, :count, :id) == 1
       assert Repo.aggregate(Item, :count, :id) == 1
       saved_budget = Repo.one(Budget)
       assert saved_budget.status == "planning"
       {:ok, next_item} = WishList.add_item(saved_budget, second_attrs)
       assert next_item.name == second_attrs.name
     end
  end

end
