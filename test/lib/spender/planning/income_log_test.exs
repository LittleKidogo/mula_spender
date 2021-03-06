defmodule Spender.Planning.IncomeLogTest do
  use Spender.DataCase

  alias Spender.Planning.IncomeLog

  @valid_attrs %{name: "Salary", amount: 46000.78}
  @invalid_attrs %{}

  describe "IncomeLog Changesets" do
    test "is valid when proper attributes are provided" do
      changeset = IncomeLog.changeset(%IncomeLog{}, @valid_attrs)
      assert changeset.valid?
    end

    test "is invalid when provided with erronous attributes" do
      changeset = IncomeLog.changeset(%IncomeLog{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "create_changeset will create an Income associated to moneylog" do
      moneylog = insert(:moneylog)
      changeset = IncomeLog.create_changeset(moneylog, @valid_attrs)
      assert changeset.valid?
      assert changeset.changes.moneylog
    end
  end
end
