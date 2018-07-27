defmodule SpenderWeb.Resolvers.WishListTest do
  use SpenderWeb.ApiCase


  alias Spender.{WishList.Item}



  describe "WishList Resolver" do
    @tag :authenticated
    test "list_items returns error if no items for budget", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      budget = insert(:budget, owner: owner)

      variables = %{
        "input" => %{
          "budget_id" => budget.id,
        }
      }

      query = """
      query($input: WishListItemsInput!){
        wishListItems(input: $input) {
          name
        }
      }
      """

      assert Repo.aggregate(Item, :count, :id) == 0

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "errors" => [error]
      } = json_response(res, 200)

      assert error["message"] == "#{budget.name} doesn't have any items"
    end

    @tag :authenticated
    test "list_items returns items for budget", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      budget = insert(:budget, owner: owner)
      insert_list(10, :wishlist_item, budget: budget)

      variables = %{
        "input" => %{
          "budget_id" => budget.id,
        }
      }

      query = """
      query($input: WishListItemsInput!){
        wishListItems(input: $input) {
          name
        }
      }
      """

      assert Repo.aggregate(Item, :count, :id) == 10

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "wishListItems" => items
        }
      } = json_response(res, 200)

      assert Enum.count(items) == Enum.count(items)
    end

    @tag :authenticated
    test "update_item returns error if item doesn't exist", %{conn: conn} do

      assert Repo.aggregate(Item, :count, :id) == 0

      variables = %{
        "input" => %{
          "id" => "5fc4f19c-43be-4e6f-88b3-42676e79fd6c",
          "name" => "Tomatoes",
          "price" => 24.0
        }
      }

      query = """
      mutation($input: WishListItemUpdateInput!) {
        updateWishListItem(input: $input) {
          name
          price
          id
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables
      %{
        "errors" => [error]
      } = json_response(res, 200)

      assert Repo.aggregate(Item, :count, :id) == 0

      assert error["message"] == "wishlist item not found"
    end

    @tag :authenticated
    test "update_item edits a saved item", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      budget = insert(:budget, owner: owner)

      item = insert(:wishlist_item, budget: budget)
      assert Repo.aggregate(Item, :count, :id) == 1

      variables = %{
        "input" => %{
          "id" => item.id,
          "name" => "Tomatoes",
          "price" => 24.0
        }
      }

      query = """
      mutation($input: WishListItemUpdateInput!) {
        updateWishListItem(input: $input) {
          name
          price
          id
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables
      %{
        "data" => %{
          "updateWishListItem" => updated_item
        }
      } = json_response(res, 200)

      assert Repo.aggregate(Item, :count, :id) == 1

      saved_item = Repo.one(Item)
      assert saved_item.id  == updated_item["id"]
      assert updated_item["name"] == variables["input"]["name"]
    end

    @tag :authenticated
    test "delete_item deletes a saved item", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      budget = insert(:budget, owner: owner)

      item = insert(:wishlist_item, budget: budget)
      assert Repo.aggregate(Item, :count, :id) == 1

      variables = %{
        "input" => %{
          "id" => item.id
        }
      }

      query = """
      mutation($input: WishListItemUpdateInput!) {
        deleteWishListItem(input: $input) {
          name
          id
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables
      %{
        "data" => %{
          "deleteWishListItem" => deleted_item
        }
      } = json_response(res, 200)

      assert Repo.aggregate(Item, :count, :id) == 0

      assert item.id  == deleted_item["id"]
      assert item.name == deleted_item["name"]
    end

    @tag :authenticated
    test "add_wishlist_item", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      budget = insert(:budget, owner: owner)

      assert Repo.aggregate(Item, :count, :id) == 0

      variables = %{
        "input" => %{
          "budget_id" => budget.id,
          "name" => "Tomatoes",
          "price" => 24.0
        }
      }

      query = """
      mutation($input: WishListItemInput!) {
        createWishListItem(input: $input) {
          name
          price
          id
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables
      %{
        "data" => %{
          "createWishListItem" => item
        }
      } = json_response(res, 200)

      assert Repo.aggregate(Item, :count, :id) == 1


      saved_item = Repo.one(Item)
      assert saved_item.id  == item["id"]
      assert item["name"] == variables["input"]["name"]
    end

    @tag :authenticated
    test "add_wishlist_item returns error if budget doesnt exist", %{conn: conn} do

      variables = %{
        "input" => %{
          "budget_id" => "5fc4f19c-43be-4e6f-88b3-42676e79fd6c",
          "name" => "Tomatoes",
          "price" => 24.0
        }
      }

      query = """
      mutation($input: WishListItemInput!) {
        createWishListItem(input: $input) {
          name
          price
          id
        }
      }
      """

      assert Repo.aggregate(Item, :count, :id) == 0

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "errors" => [error]
      } = json_response(res, 200)

      assert error["message"] == "budget with id: 5fc4f19c-43be-4e6f-88b3-42676e79fd6c not found"
    end
  end

end
