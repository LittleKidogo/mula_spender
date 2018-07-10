defmodule Spender.Planning.LogCategoryTest do
  use Spender.DataCase
  alias Spender.Planning.LogCategory

  @moduledoc """
    This module performs tests for the log-category changeset
  """

  @invalid_log %{}
  @valid_log %{name: "Food"}

  describe "LogCategory changeset" do
    test " is valid when provided the log name " do
      changeset = LogCategory.changeset(%LogCategory{}, @valid_log)
      assert changeset.valid?
    end

    test "is invalid when provided no log name" do
      changeset = LogCategory.changeset(%LogCategory{}, @invalid_log)
      refute changeset.valid?
    end

    test "create_changeset will create an LogCategory associated to budget" do
      budget = insert(:budget)
      changeset = LogCategory.create_changeset(budget, @valid_log)
      assert changeset.valid?
      assert changeset.changes.budget
    end
  end
end
