defmodule SpenderWeb.Resolvers.OwnerTest do
  use SpenderWeb.ApiCase

  alias Spender.AbsintheHelpers

  alias Spender.MoneyLogs.{Moneylog, Owner}


  describe "Owner Resolver" do
    @tag :authenticated
    test "lists owners moneylog", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      moneylog = insert_list(10, :moneylog, owner: owner)

      query = """
      {
        moneylog {
          name
        }
      }
      """

      res = conn  |> get("/graphiql", AbsintheHelpers.query_skeleton(query,"moneylog"))

      %{
        "data" => %{
          "moneylog" => fetched_moneylog
        }
      } = json_response(res, 200)

      assert Enum.count(fetched_moneylog) == Enum.count(moneylog)
    end

    @tag :authenticated
    test "returns error when moneylog is nil", %{conn: conn, current_user: user} do
      # insert an onwer
      insert(:owner, user: user)
      query = """
      {
        moneylog {
          name
        }
      }
      """

      res = conn  |> get("/graphiql", AbsintheHelpers.query_skeleton(query,"moneylog"))

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
    test "create_moneylog when an owner exists", %{conn: conn, current_user: user} do
      insert(:owner, user: user)

      variables = %{
        "input" => %{
          "name" => "Food Lovers"
        }
      }

      query = """
      mutation($input: MoneylogInput!) {
        createMoneylog(input: $input) {
          name
        }
      }
      """

      conn = post conn, "/graphiql", query: query, variables: variables
      assert json_response(conn, 200) == %{
        "data" => %{
          "createMoneylog" => %{
            "name" => variables["input"]["name"]
          }
        }
      }
    end

    @tag :authenticated
    test "create_moneylog when owner does not exist", %{conn: conn} do

      variables = %{
        "input" => %{
          "name" => "Food Lovers"
        }
      }

      query = """
      mutation($input: MoneylogInput!) {
        createMoneylog(input: $input) {
          name
        }
      }
      """

      assert Repo.aggregate(Moneylog, :count, :id) == 0
      assert Repo.aggregate(Owner, :count, :id) == 0

      conn = post conn, "/graphiql", query: query, variables: variables
      assert Repo.aggregate(Moneylog, :count, :id) == 1
      assert Repo.aggregate(Owner, :count, :id) == 1

      assert json_response(conn, 200) == %{
        "data" => %{
          "createMoneylog" => %{
            "name" => variables["input"]["name"]
          }
        }
      }

    end

    @tag :authenticated
    test "update_moneylog errors out when moneylog doesn't exist", %{conn: conn} do
      variables = %{
        "input" => %{
          "id" => "5fc4f19c-43be-4e6f-88b3-42676e79fd6c",
          "name" => "Food Lovers",
          "startDate" => "2018-07-12",
          "endDate" => "2018-07-20"
        }
      }

      query = """
      mutation($input: MoneylogUpdate!) {
        updateMoneylog(input: $input) {
          name
          id
        }
      }
      """

      assert Repo.aggregate(Moneylog, :count, :id) == 0

      conn = post conn, "/graphiql", query: query, variables: variables
      assert Repo.aggregate(Moneylog, :count, :id) == 0

      %{
        "errors" => [error]
      } = json_response(conn, 200)

      assert error["message"] == "moneylog with id: 5fc4f19c-43be-4e6f-88b3-42676e79fd6c not found"
    end

    @tag :authenticated
    test "update_moneylog with new details", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      moneylog = insert(:moneylog, owner: owner)
      variables = %{
        "input" => %{
          "id" => moneylog.id,
          "name" => "Food Lovers",
          "startDate" => "2018-07-12",
          "endDate" => "2018-07-20"
        }
      }

      query = """
      mutation($input: MoneylogUpdate!) {
        updateMoneylog(input: $input) {
          name
          id
        }
      }
      """

      assert Repo.aggregate(Moneylog, :count, :id) == 1

      conn = post conn, "/graphiql", query: query, variables: variables
      assert Repo.aggregate(Moneylog, :count, :id) == 1

      %{
        "data" => %{
          "updateMoneylog" => updatedMoneylog
        }
      } = json_response(conn, 200)

      assert updatedMoneylog["name"] == variables["input"]["name"]
      assert updatedMoneylog["id"] == moneylog.id
    end

    @tag :authenticated
    test "delete_moneylog deletes moneylog when moneylog exists", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      moneylog = insert(:moneylog, owner: owner)
      variables = %{
        "input" => %{
          "id" => moneylog.id,
          "name" => moneylog.name
        }
      }

      query = """
      mutation($input: MoneylogUpdate!) {
        deleteMoneylog(input: $input) {
          name
          id
        }
      }
      """

      assert Repo.aggregate(Moneylog, :count, :id) == 1

      conn = post conn, "/graphiql", query: query, variables: variables
      %{
        "data" => %{
          "deleteMoneylog" => updatedMoneylog
        }
      } = json_response(conn, 200)

      assert Repo.aggregate(Moneylog, :count, :id) == 0


      assert updatedMoneylog["name"] == variables["input"]["name"]
      assert updatedMoneylog["id"] == moneylog.id
    end

    @tag :authenticated
    test "delete_moneylog errors out when moneylog doesn't exist", %{conn: conn} do
      variables = %{
        "input" => %{
          "id" => "5fc4f19c-43be-4e6f-88b3-42676e79fd6c",
          "name" => "Food Lovers",
          "startDate" => "2018-07-12",
          "endDate" => "2018-07-20"
        }
      }

      query = """
      mutation($input: MoneylogUpdate!) {
        deleteMoneylog(input: $input) {
          name
          id
        }
      }
      """

      assert Repo.aggregate(Moneylog, :count, :id) == 0

      conn = post conn, "/graphiql", query: query, variables: variables
      assert Repo.aggregate(Moneylog, :count, :id) == 0

      %{
        "errors" => [error]
      } = json_response(conn, 200)

      assert error["message"] == "moneylog with id: 5fc4f19c-43be-4e6f-88b3-42676e79fd6c not found"
    end
  end
end
