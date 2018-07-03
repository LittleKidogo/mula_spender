defmodule SpenderWeb.Resolvers.PlanningTest do
  use SpenderWeb.ApiCase

  alias Spender.{
    Planning.LogSection,
    Planning.IncomeLog
  }

  @num_sections 5

  @valid_attrs %{name: "Section-1", duration: 23.5, section_position: 2}


  describe "Planning Resolver" do
    @tag :authenticated
    @tag :new
    test "link_item should associate an item to a section", %{conn: conn} do
      budget = insert(:budget)
      item = insert(:wishlist_item, budget: budget)
      section = insert(:log_section, budget: budget)

      loaded_item = item |> Repo.preload(:log_sections)
      assert Enum.count(loaded_item.log_sections) == 0
      variables = %{
        "input" => %{
          "item_id" => item.id,
          "section_id" => section.id
        }
      }

      query = """
      mutation($input: LinkItemInput!) {
        linkItem(input: $input) {
          id
          name
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "linkItem" => loaded_section
        }
      } = json_response(res, 200)

    refute item |> Repo.preload(:log_sections) == nil
    assert loaded_section["id"] == section.id
    IO.inpsect loaded_section
    end

    @tag :authenticated
    test "add_income should save an income", %{conn: conn} do
      budget = insert(:budget)
      assert Repo.aggregate(IncomeLog, :count, :id) == 0
      variables =  %{
        "input" => %{
          "budget_id" => budget.id,
          "amount" => 3400.9,
          "name" => "Movie Gig",
          "type" => "Movie Work",
          "earn_date" => Date.to_string(NaiveDateTime.to_date(NaiveDateTime.utc_now()))
        }
      }

      query = """
      mutation($input: IncomeLogInput!) {
        addIncomeLog(input: $input) {
          name
          amount
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "addIncomeLog" => log
        }
      } = json_response(res, 200)

      assert Repo.aggregate(IncomeLog, :count, :id) == 1
      assert log["name"] == variables["input"]["name"]
    end

    @tag :authenticated
    test "delete_income should delete a saved income", %{conn: conn} do
      incomelog = insert(:income_log)
      assert Repo.aggregate(IncomeLog, :count, :id) == 1

      variables =  %{
        "input" => %{
          "id" => incomelog.id
        }
      }

      query = """
      mutation($input: IncomeLogInput!) {
        deleteIncomeLog(input: $input) {
          id
          name
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "deleteIncomeLog" => deleted_log
        }
      } = json_response(res, 200)

      assert Repo.aggregate(IncomeLog, :count, :id) == 0
      assert deleted_log["id"] == incomelog.id
      assert deleted_log["name"] == incomelog.name
    end

    @tag :authenticated
    test "update_income should edit a saved income", %{conn: conn} do
      budget = insert(:budget)
      income_log = insert(:income_log, budget: budget)
      assert Repo.aggregate(IncomeLog, :count, :id) == 1
      saved_log = Repo.one(IncomeLog)
      assert saved_log.id == income_log.id
      variables =  %{
        "input" => %{
          "id" => income_log.id,
          "amount" => 3400.9,
          "name" => "Movie Gig",
          "type" => "Movie Work",
          "earn_date" => Date.to_string(NaiveDateTime.to_date(NaiveDateTime.utc_now()))
        }
      }
      refute saved_log.name == variables["input"]["name"]
      query = """
      mutation($input: IncomeLogUpdateInput!) {
        updateIncomeLog(input: $input) {
          id
          name
          amount
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "updateIncomeLog" => updated_log
        }
      } = json_response(res, 200)

      assert Repo.aggregate(IncomeLog, :count, :id) == 1
      assert updated_log["id"] == income_log.id
      assert updated_log["name"] == variables["input"]["name"]
      assert updated_log["amount"] == variables["input"]["amount"]
    end

    @tag :authenticated
    test "sections should fetch sections in a budget", %{conn: conn, current_user: user} do
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
        sections(input: $input){
          name
        }
      }
      """

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "sections" => sections
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

    @tag :authenticated
    test "update_section should update a saved section", %{conn: conn} do
      logsection = insert(:log_section, @valid_attrs)

      variables = %{
        "input" => %{
          "id" => logsection.id,
          "name" => "New Updated Name"
        }
      }

      query = """
      mutation($input: LogSectionUpdate!) {
        updateLogSection(input: $input) {
          id
          name
        }
      }
      """

      assert Repo.aggregate(LogSection, :count, :id) == 1

      res = post conn, "/graphiql", query: query, variables: variables

      %{
        "data" => %{
          "updateLogSection" => updated_section
        }
      } = json_response(res, 200)

      assert Repo.aggregate(LogSection, :count, :id) == 1
      assert updated_section["name"] == variables["input"]["name"]
      assert updated_section["id"] == logsection.id
    end
  end
end
