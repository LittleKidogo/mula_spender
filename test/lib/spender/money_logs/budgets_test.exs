defmodule Spender.MoneyLogs.BudgetTest do
  use Spender.DataCase
  alias Spender.MoneyLogs.Budget

  @valid_attrs %{name: "Budget", start_date: "2018-03-03", end_date: "2018-03-04"}
  @invalid_attrs %{}
  describe "budgets " do
    test " valid changeset if attributes are valid" do
      changeset = Budget.changeset(%Budget{}, @valid_attrs)
      assert changeset.valid?
    end

    test " invalid changeset if invalid attributes are provided" do
      changeset = Budget.changeset(%Budget{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
