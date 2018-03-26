defmodule SpenderWeb.Resolvers.UserTest do
  use SpenderWeb.ApiCase

  alias Spender.AbsintheHelpers

  describe "User Resolver" do
    test "users/3 lists all users", %{conn: conn} do
      loaded_users = insert_list(24, :user)

      query = """
      {
        users {
          email
        }
      }
      """

      res = conn |> get("/graphiql", AbsintheHelpers.query_skeleton(query, "users"))

      %{
        "data" => %{
          "users" => fetched_users
        }
      } =json_response(res, 200)

      assert Enum.count(fetched_users) == Enum.count(loaded_users)
    end

    @tag :authenticated
    test "update_user/3 should edit a saved user", %{conn: conn} do
      load_user = insert(:user)
      first_name = "Zacck"

      query = """
      mutation {
        updateUser(firstName: #{first_name}) {
          firstName
        }
      }
      """
      res = conn |> post("/graphiql", AbsintheHelpers.mutation_skeleton(query))

      %{
        "data" => %{
          "user" => user
        }
      } = json_response(res, 200)

      assert user.email == load_user.email
      assert user.first_name == first_name
    end

    end
    test "user/3 shows the relevant user detals", %{conn: conn} do
      load_user = insert(:user)

      query = """
      {
        user(id: #{load_user.id}) {
          email
        }
      }
      """

      res = conn |> get("/graphiql", AbsintheHelpers.query_skeleton(query, "user"))

      %{
        "data" => %{
          "user" => fetched_user
        }
      } =json_response(res, 200)

      assert fetched_user["email"] == load_user.email

    end
end
