defmodule Spender.WishList.ItemTest do
  use Spender.DataCase
  alias Spender.{
    Planning,
    WishList.Item
  }

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
      item = item |> Repo.preload(:log_sections)
      changeset = Item.add_to_section(item,log_section)
      assert changeset.valid?
      assert changeset.changes.log_sections
    end

    test "should remove association between an item and a log_section" do
      log_section = insert(:log_section)
      item = insert(:wishlist_item, @valid_attrs)
      item = item |> Repo.preload(:log_sections)
      assert Enum.count(item.log_sections) == 0
      changeset = Item.add_to_section(item,log_section)
      {:ok, updated_item} = changeset |> Repo.update()
      assert Enum.count(updated_item.log_sections) == 1
      new_changeset = Item.remove_from_section(updated_item, log_section)
      assert new_changeset.valid?
      assert new_changeset.changes.log_sections
    end

    test "should associate not item more log_sections than qpm" do
      log_section = insert(:log_section)
      item = insert(:wishlist_item, @valid_attrs)
      item = item |> Repo.preload(:log_sections)
      Planning.add_item_to_section(item, log_section)
      saved_item = Repo.one(Item) |> Repo.preload(:log_sections)
      log_section1 = insert(:log_section)
      changeset = Item.add_to_section(saved_item, log_section1)
      refute changeset.valid?
    end
  end
end
