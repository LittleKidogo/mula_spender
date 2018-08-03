defmodule Spender.WishListTest do
  use Spender.DataCase
  alias Spender.{WishList, MoneyLogs.Moneylog, WishList.Item}

  describe "WishList Context" do
    test "lists all the items that belong a moneylog (wishlist)" do
      moneylog = insert(:moneylog)
      insert_list(25, :wishlist_item, moneylog: moneylog)
      {:ok, fetched_items} = WishList.list_items(moneylog)
      assert Enum.count(fetched_items) == 25
    end

    test "add item should add an item and update a moneylog status" do
      moneylog = insert(:moneylog)
      attrs = %{name: "Oats", price: 25.34}
      assert Repo.aggregate(Moneylog, :count, :id) == 1
      assert Repo.aggregate(Item, :count, :id) == 0
      {:ok, item} = WishList.add_item(moneylog, attrs)
      assert Repo.aggregate(Moneylog, :count, :id) == 1
      assert Repo.aggregate(Item, :count, :id) == 1
      saved_moneylog = Repo.one(Moneylog)
      assert item.moneylog_id == moneylog.id
      assert item.name == attrs.name
      assert saved_moneylog.id == moneylog.id
      assert saved_moneylog.status == "planning"
     end

     test "adds an item to moneylog in planning" do
       moneylog = insert(:moneylog)
       first_attrs = %{name: "Oats", price: 25.34}
       second_attrs = %{name: "Rice Flour", price: 15.00}
       assert Repo.aggregate(Moneylog, :count, :id) == 1
       assert Repo.aggregate(Item, :count, :id) == 0
       {:ok, _item} = WishList.add_item(moneylog, first_attrs)
       assert Repo.aggregate(Moneylog, :count, :id) == 1
       assert Repo.aggregate(Item, :count, :id) == 1
       saved_moneylog = Repo.one(Moneylog)
       assert saved_moneylog.status == "planning"
       {:ok, next_item} = WishList.add_item(saved_moneylog, second_attrs)
       assert next_item.name == second_attrs.name
     end

     test "get_item gets an exising item" do
       item = insert(:wishlist_item)

       {:ok, saved_item} = WishList.get_item(item.id )

       assert saved_item.name == item.name
     end

     test "get_item returns error if item doesnt exist" do
       assert {:error, "wishlist item not found"} = WishList.get_item("6477f136-4df0-4bfe-b9cd-5d6c55399849")
     end

     test "update item should edit a saved item" do
       moneylog = insert(:moneylog)
       item =  insert(:wishlist_item, moneylog: moneylog)

       update_attrs = %{name: "Oats", price: 25.34}

       assert Repo.aggregate(Item, :count, :id) == 1


       {:ok, edited_item} = WishList.update_item(item, update_attrs)

       assert Repo.aggregate(Item, :count, :id) == 1

       assert edited_item.id == item.id
       assert edited_item.name ==  update_attrs.name
     end

     test "delete_item should delete a saved item" do
       item = insert(:wishlist_item)

       assert Repo.aggregate(Item, :count, :id) ==  1

       {:ok, deleted_item} = WishList.delete_item(item)

       assert Repo.aggregate(Item, :count, :id) == 0

       assert deleted_item.id == item.id
     end
  end

end
