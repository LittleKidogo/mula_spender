defmodule Spender.Planning.IncomeTypetest do
  @moduledoc """
    This module contains tests for the income type changeset
  """
  use Spender.DataCase
  alias Spender.Planning.IncomeType

  @valid_income_type %{name: "Business", balance: "1500.50"}
  @invalid_income_type %{}

  describe "Income_type changeset" do
    test "Is valid when provided the right attributes" do
      changeset = IncomeType.changeset(%IncomeType{}, @valid_income_type)
      assert changeset.valid?
    end

    test "Is invalid when provided with the wrong attributes" do
      changeset = IncomeType.changeset(%IncomeType{}, @invalid_income_type)
      refute changeset.valid?
    end

    test " create a changeset that will create an incometype associated to the moneylog " do
      moneylog = insert(:moneylog)
      changeset = IncomeType.create_changeset(moneylog, @valid_income_type)
      assert changeset.valid?
      assert changeset.changes.moneylog
    end
  end
end
