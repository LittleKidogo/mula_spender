defmodule Spender.MoneyLogsTest do
  use Spender.DataCase

  alias Spender.MoneyLogs

  describe "moneylogs " do
    test "list budgets/1 returns all budgets that belong to a user" do
      user = insert(:user)
      owner = insert(:owner, user: user)
      insert(:budget, owner: owner)
      insert(:budget, owner: owner)

      budgets = Repo.all(MoneyLogs.Budget)

      assert MoneyLogs.list_budgets(user).budgets |> Enum.sort == budgets |> Enum.sort
  end
end
