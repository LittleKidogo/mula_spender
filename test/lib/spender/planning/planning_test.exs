defmodule Spender.PlanningTest do
  use Spender.DataCase

  alias Spender.{
    Planning,
    Planning.LogSection,
    Planning.IncomeLog,
    MoneyLogs.Budget,
    WishList.Item
  }

  @num_sections 5
  @valid_attrs %{name: "Section-1", duration: 23.5, section_position: 2}
  @update_attrs %{name: "First Week"}
  @log_attrs %{name: "Salary", amount: 67000.9, earn_date: NaiveDateTime.to_date(NaiveDateTime.utc_now)}

  describe "Planning Boundary" do

    test "add_item_to_section should associate an item with a section" do
      section = insert(:log_section)
      item = insert(:wishlist_item)
      assert Repo.aggregate(LogSection, :count, :id) == 1
      assert Repo.aggregate(Item, :count, :id) == 1
      Repo.all(Item)
      Repo.all(LogSection)
      {:ok, updated_section} = Planning.add_item_to_section(item, section)
      assert Repo.aggregate(LogSection, :count, :id) == 1
      assert Repo.aggregate(Item, :count, :id) == 1
      assert Enum.count(updated_section.wishlist_items) == 1
    end

    test "get_income should return an error if income doesnt exist" do
      {:error, "Income doesn't exist"} = Planning.get_income(45)
    end

    test "get_income should return an income if one exists" do
      income = insert(:income_log)
      {:ok, %IncomeLog{} = saved_income} = Planning.get_income(income.id)
      assert saved_income.name
      assert saved_income.amount
    end

    test "delete_income should delete an existing income" do
      income = insert(:income_log)
      {:ok, deleted_income} = Planning.delete_income(income)
      assert income.id == deleted_income.id
    end

    test "add_income save an income attached to budget" do
      budget = insert(:budget)
      assert Repo.aggregate(IncomeLog, :count, :id) == 0
      {:ok, incomelog} = Planning.add_income(budget, @log_attrs)
      assert Repo.aggregate(IncomeLog, :count, :id) == 1
      assert incomelog.earn_date == NaiveDateTime.to_date(NaiveDateTime.utc_now)
      assert incomelog.name == @log_attrs.name
      assert incomelog.amount == @log_attrs.amount
    end

    test "update_income should update a saved income" do
      budget = insert(:budget)
      incomelog = insert(:income_log, budget: budget)
      refute incomelog.name == @log_attrs.name
      {:ok, updated_income} = Planning.update_income(incomelog, @log_attrs)
      assert updated_income.id == incomelog.id
      assert updated_income.name == @log_attrs.name
      assert updated_income.amount == @log_attrs.amount
    end

    test "add_sections should return an error if start_date and end_date are not set for a budget" do
      no_date_attrs = %{name: "Food Lovers", start_date: nil, end_date: nil}
      budget = insert(:budget, no_date_attrs)

     {:error, message} = Planning.add_sections(budget, @num_sections)

     assert message == "#{budget.name} needs a start date and an end date"
    end

    test "add_sections should return a budget preloaded with sections" do
      budget = insert(:budget)
      assert Repo.aggregate(LogSection, :count, :id) == 0
      {:ok, budget} = Planning.add_sections(budget, @num_sections)
      assert Repo.aggregate(LogSection, :count, :id) == @num_sections
      assert Enum.count(budget.logsections) == @num_sections
    end

    test "get_sections should return an error if the budget has no sections" do
      budget = insert(:budget)
      assert Repo.aggregate(Budget, :count, :id) == 1
      assert Repo.aggregate(LogSection, :count, :id) == 0
      assert {:error, "#{budget.name} doesn't have any sections"} == Planning.get_sections(budget)
    end

    test "get_sections should return sections from a MoneyLog" do
      budget = insert(:budget)
      insert_list(@num_sections, :log_section, budget: budget)
      assert Repo.aggregate(Budget, :count, :id) == 1
      assert Repo.aggregate(LogSection, :count, :id) == @num_sections
      {:ok, sections} = Planning.get_sections(budget)
      assert Enum.count(sections) == @num_sections
    end

    test "get_section should return an error if no section" do
      assert Repo.aggregate(LogSection, :count, :id) == 0
      {:error, "Section doesn't exist" } = Planning.get_section(54)
    end

    test "get_section should return a section from the database" do
      section = insert(:log_section)
      assert Repo.aggregate(LogSection, :count, :id) == 1
      {:ok, saved_section} = Planning.get_section(section.id)
      assert saved_section.id == section.id
      assert section.name == saved_section.name
    end

    test "update_section should update a saved section" do
      section = insert(:log_section, @valid_attrs)
      assert Repo.aggregate(LogSection, :count, :id) == 1
      {:ok, updated_section} = Planning.update_section(section, @update_attrs)
      assert Repo.aggregate(LogSection, :count, :id) == 1
      assert updated_section.id == section.id
      assert updated_section.name == @update_attrs.name
    end
  end
end
