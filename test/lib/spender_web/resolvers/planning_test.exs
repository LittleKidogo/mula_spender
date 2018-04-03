defmodule SpenderWeb.Resolvers.PlanningTest do
  use SpenderWeb.ApiCase

  alias Spender.{
    Planning.LogSection,
    MoneyLogs.Budget
  }

  @num_sections 5

  describe "Planning Resolver" do
    @tag :authenticated
    test "get_sections should fetch sections in a budget", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      budget = insert(:budget, owner: owner)
      insert_list(@num_sections, :log_section, budget: budget)

      variables = %{
        "input" => %{
          "budget_id" => budget.id
        }
      }

      query = """
      query($input: GetSectionsInput!) {
        getSections(input: $input){
          name
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "getSections" => sections
        }
      } = json_response(res, 200)

      assert Enum.count(sections) == @num_sections
    end

    @tag :authenticated
    test "add_sections should add sections for a budget", %{conn: conn, current_user: user} do
      owner = insert(:owner, user: user)
      budget = insert(:budget, owner: owner)

      variables = %{
        "input" => %{
          "budget_id" => budget.id,
          "sections" => @num_sections
        }
      }

      query = """
      mutation($input: LogSectionsInput!) {
        addLogSections(input: $input) {
          name
          logsections {
            name
          }
        }
      }
      """

      assert Repo.aggregate(LogSection, :count, :id) == 0

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "addLogSections" => sectioned_budget
        }
      } = json_response(res, 200)

      assert Repo.aggregate(LogSection, :count, :id) == @num_sections
      assert sectioned_budget["name"] == budget.name
      assert Enum.count(sectioned_budget["logsections"]) == @num_sections
    end
  end
end
