defmodule Spender.Repo.Migrations.RenameItemsTable do
  use Ecto.Migration

  def change do
    rename table(:items), to: table(:wishlist_items)
  end
end
