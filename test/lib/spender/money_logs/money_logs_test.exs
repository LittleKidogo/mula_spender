defmodule Spender.MoneyLogsTest do
  use Spender.DataCase

  alias Spender.{MoneyLogs, MoneyLogs.Owner}

  @valid_budget %{name: "Budget", start_date: "2018-03-03", end_date: "2018-03-04"}
  @updated_budget %{name: "Budget-Update", start_date: "2018-03-03", end_date: "2018-03-04"}
  describe "moneylogs " do
    test "list budgets/1 returns all budgets that belong to a user" do
      user = insert(:user)
      owner = insert(:owner, user: user)
      insert(:budget, owner: owner)
      insert(:budget, owner: owner)

      budgets = Repo.all(MoneyLogs.Budget)

      assert MoneyLogs.list_budgets(owner).budgets |> Enum.sort == budgets |> Enum.sort
    end

    test "create_budget/2 creates and returns a budget when attributes are valid" do
      owner = insert(:owner)
      %{name: name } = @valid_budget

      {:ok, budget} = MoneyLogs.create_budget(owner, @valid_budget)
      assert Repo.one(MoneyLogs.Budget)
      assert budget.name == name
    end

    test "update_moneylog/2 updates the details of a moneylog" do
      %{name: name } = @updated_budget
      budget = insert(:budget, @valid_budget)
      {:ok, budget} = MoneyLogs.update_budget(budget, @updated_budget)
      assert budget.name  == name
    end

    test "create owner saves an onwer" do
      attrs = %{name: "Zacck"}
      user = insert(:user)
      assert Repo.aggregate(Owner, :count, :id) == 0
      {:ok, owner} = MoneyLogs.create_owner(user,attrs)
      assert Repo.aggregate(Owner, :count, :id) == 1
      assert owner.name == attrs.name
    end
  end
end
