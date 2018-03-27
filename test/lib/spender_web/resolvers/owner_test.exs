defmodule SpenderWeb.Resolvers.OwnerTest do
  use SpenderWeb.ApiCase

  alias Spender.AbsintheHelpers

  alias Spender.MoneyLogs.{Budget, Owner}


  describe "Owner Resolver" do
    @tag :authenticated
    test "lists owners budgets", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      budgets = insert_list(10, :budget, owner: owner)

      query = """
      {
        budgets {
          name
        }
      }
      """

      res = conn  |> get("/graphiql", AbsintheHelpers.query_skeleton(query,"budgets"))

      %{
        "data" => %{
          "budgets" => fetched_budgets
        }
      } = json_response(res, 200)

      assert Enum.count(fetched_budgets) == Enum.count(budgets)
    end

    @tag :authenticated
    test "returns error when budgets is nil", %{conn: conn, current_user: user} do
      # insert an onwer
      insert(:owner, user: user)
      query = """
      {
        budgets {
          name
        }
      }
      """

      res = conn  |> get("/graphiql", AbsintheHelpers.query_skeleton(query,"budgets"))

      %{
        "errors" => [error]
        } = json_response(res, 200)

        assert error["message"] == "user doesn't have any moneylogs"

    end

    @tag :authenticated
    test "fetches an existing owner", %{conn: conn, current_user: user} do
      # insert an onwer
      owner = insert(:owner, user: user)

      #build the query
      query = """
      {
        owner {
          name
        }
      }
      """

      # run the query
      res = conn |> get("/graphiql", AbsintheHelpers.query_skeleton(query, "owner"))

      assert json_response(res, 200) == %{
        "data" => %{
          "owner" => %{
            "name" => owner.name
          }
        }
      }
    end

    @tag :authenticated
    test "returns no existing owner error", %{conn: conn} do
      #build the query
      query = """
      {
        owner {
          name
        }
      }
      """

      # run the query
      res = conn |> get("/graphiql", AbsintheHelpers.query_skeleton(query, "owner"))

      %{
        "errors" => [error]
        } = json_response(res, 200)

        assert error["message"] == "owner not found"
    end

    @tag :authenticated
    test "create_budget when an owner exists", %{conn: conn, current_user: user} do
      insert(:owner, user: user)

      variables = %{
        "input" => %{
          "name" => "Food Lovers"
        }
      }

      query = """
      mutation($input: BudgetInput!) {
        createBudget(input: $input) {
          name
        }
      }
      """

      conn = post conn, "/graphiql", query: query, variables: variables
      assert json_response(conn, 200) == %{
        "data" => %{
          "createBudget" => %{
            "name" => variables["input"]["name"]
          }
        }
      }
    end

    @tag :authenticated
    test "create_budget when owner does not exist", %{conn: conn} do

      variables = %{
        "input" => %{
          "name" => "Food Lovers"
        }
      }

      query = """
      mutation($input: BudgetInput!) {
        createBudget(input: $input) {
          name
        }
      }
      """

      assert Repo.aggregate(Budget, :count, :id) == 0
      assert Repo.aggregate(Owner, :count, :id) == 0

      conn = post conn, "/graphiql", query: query, variables: variables
      assert Repo.aggregate(Budget, :count, :id) == 1
      assert Repo.aggregate(Owner, :count, :id) == 1

      assert json_response(conn, 200) == %{
        "data" => %{
          "createBudget" => %{
            "name" => variables["input"]["name"]
          }
        }
      }

    end
  end
end
