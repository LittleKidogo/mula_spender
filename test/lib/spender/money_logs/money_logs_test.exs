defmodule Spender.MoneyLogsTest do
  use Spender.DataCase

  alias Spender.MoneyLogs

  describe "moneylogs " do
    test "list budgets/1 returns all budgets that belong to a user" do
      user = insert(:user)
      owner = insert(:owner, user: user)
      budget1 = insert(:budget, owner: owner)
      budget2 = insert(:budget, owner: owner)

      assert MoneyLogs.list_budgets(user) == [budget1, budget2]
    end
  end
end
