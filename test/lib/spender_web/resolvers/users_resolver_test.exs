defmodule SpenderWeb.UserResolverTest do
  use SpenderWeb.ConnCase
  
  alias Spender.AbsintheHelpers

  describe "User Resolver" do 
    test "all_users/3 returns all users on the system", %{conn: conn} do
      insert_pair(:user)

      query = """
      {
        allUsers {
          email
        }
      }
      """

      res = conn
            |> post("/graphiql", AbsintheHelpers.query_skeleton(query,""))
      assert json_response(res, 200)["data"]
    end 
  end 
end 
