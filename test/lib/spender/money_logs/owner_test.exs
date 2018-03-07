defmodule Spender.MoneyLogs.OwnerTest do
  use Spender.DataCase
  alias Spender.MoneyLogs.Owner

  @valid_attrs %{name: "Zacck"}
  @invalid_attrs %{}

  describe "owner changests " do
    test " with valid attributes" do
      changeset = Owner.changeset(%Owner{}, @valid_attrs)
      assert changeset.valid?
    end

    test " fails with invalid_attrs" do
      changeset = Owner.changeset(%Owner{}, @invalid_attrs)
      refute changeset.valid?
    end
  end
end
