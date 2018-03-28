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
  end

end
