defmodule Spender.Using.PaymentMethodTest do
  @moduledoc"""
  This module performs tests the payment method changeset
"""
  use Spender.DataCase
  alias Spender.Using.PaymentMethod

  @valid_method %{name: "cash", balance: "1234.67"}
  @invalid_method %{}

  describe "Payment method Changeset tests " do
    test "Valid when provided with the right attributes"do
      changeset = PaymentMethod.changeset(%PaymentMethod{}, @valid_method)
      assert changeset.valid?
    end
    test "Invalid when provided with the wrong attributes" do
      changeset =PaymentMethod.changeset(%PaymentMethod{}, @invalid_method)
      refute changeset.valid?
    end
    test "Create_changeset will associate the Payment method to the Budget id" do
      budget =insert(:budget)
      changeset = PaymentMethod.create_changeset(budget, @valid_method)
      assert changeset.valid?
      assert changeset.changes.budget
    end
  end
end