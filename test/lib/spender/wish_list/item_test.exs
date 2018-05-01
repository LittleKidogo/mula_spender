defmodule Spender.WishList.ItemTest do
  use Spender.DataCase
  alias Spender.WishList.Item

  @valid_attrs %{name: "Soap", price: 10.3}
  @invalid_attrs %{name: "Soap", }

  describe "item changesets" do
    test "should be valid with correct input" do
      changeset = Item.changeset(%Item{}, @valid_attrs)
      assert changeset.valid?
    end

    test " should fail with invalid inputs" do
      changeset = Item.changeset(%Item{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "should associate an item with a budget" do
      budget = insert(:budget)
      changeset = Item.create_changeset(budget, @valid_attrs)
      assert changeset.valid?
      assert changeset.changes.budget
    end

    test "should associate an item to a log_section" do
      log_section = insert(:log_section)
      item = insert(:wishlist_item, @valid_attrs)
      item = item |> Repo.preload(:log_section)
      changeset = Item.add_to_section(item,log_section)
      assert changeset.valid?
      assert changeset.changes.log_section
    end
  end
end
