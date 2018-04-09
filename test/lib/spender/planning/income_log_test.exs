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
  end
end
