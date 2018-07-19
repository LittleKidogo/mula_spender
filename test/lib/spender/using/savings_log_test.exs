defmodule Spender.Using.SavingsLogTest do
  @moduledoc """
  This module defines tests for the SavingsLog module
  """
  use Spender.DataCase
  alias Spender.Using.SavingsLog

  @valid_data %{name: "Car", amount: 137.50}
  @no_amount %{name: "Hike"}
  @no_name %{amount: 23.50}

  describe "SavingsLog changeset" do
    test "is valid when provided correct attributes" do
      changeset = SavingsLog.changeset(%SavingsLog{}, @valid_data)
      assert changeset.valid?
    end

    test "is invalid without a name" do
      changeset = SavingsLog.changeset(%SavingsLog{}, @no_name)
      refute changeset.valid?
    end

    test "data is invalid without amount" do
      changeset = SavingsLog.changeset(%SavingsLog{}, @no_amount)
      refute changeset.valid?
    end
  end
end
