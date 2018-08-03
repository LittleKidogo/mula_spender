defmodule Spender.Using.PaymentMethodTest do
  @moduledoc """
    This module performs tests the payment method changeset
  """
  use Spender.DataCase
  alias Spender.Using.PaymentMethod

  @valid_method %{name: "cash", balance: "1234.67"}
  @invalid_method %{}

  describe "Payment method Changeset tests " do
    test "Valid when provided with the right attributes" do
      changeset = PaymentMethod.changeset(%PaymentMethod{}, @valid_method)
      assert changeset.valid?
    end

    test "Invalid when provided with the wrong attributes" do
      changeset = PaymentMethod.changeset(%PaymentMethod{}, @invalid_method)
      refute changeset.valid?
    end

    test "Create_changeset will associate the Payment method to the moneylog id" do
      moneylog = insert(:moneylog)
      changeset = PaymentMethod.create_changeset(moneylog, @valid_method)
      assert changeset.valid?
      assert changeset.changes.moneylog
    end
  end
end
