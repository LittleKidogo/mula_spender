defmodule SpenderWeb.Resolvers.OwnerTest do
  use SpenderWeb.ApiCase

  alias Spender.AbsintheHelpers


  describe "Owner Resolver" do
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
  end
end
