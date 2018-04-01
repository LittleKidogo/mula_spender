defmodule Spender.Planning.LogSectionTest do
  use Spender.DataCase

  alias Spender.Planning.LogSection

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
end
