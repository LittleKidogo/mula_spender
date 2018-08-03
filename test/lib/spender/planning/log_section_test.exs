defmodule Spender.Planning.LogSectionTest do
  use Spender.DataCase

  alias Spender.{
    Planning,
    Planning.LogSection
  }

  @valid_attrs %{name: "Section-1", duration: 23.5, section_position: 2}
  @invalid_attrs %{}

  test "returns valid changeset with valid data" do
    changeset = LogSection.changeset(%LogSection{}, @valid_attrs)
    assert changeset.valid?
  end

  test "returns invalud changeset with invalid data" do
    changeset = LogSection.changeset(%LogSection{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "it should associate a LogSection to a moneylog" do
    moneylog = insert(:moneylog)
    changeset = LogSection.create_changeset(moneylog, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.moneylog
  end

  test "it should unlink a LogSection from a WishListItem" do
    logsection = insert(:log_section)
    item = insert(:wishlist_item)
    loaded_section = logsection |> Repo.preload(:wishlist_items)
    assert Enum.count(loaded_section.wishlist_items) == 0
    {:ok, updated_section} = Planning.add_item_to_section(item, logsection)
    assert Enum.count(updated_section.wishlist_items) == 1
    new_changeset = LogSection.remove_item(updated_section, item)
    assert new_changeset.valid?
  end

end
