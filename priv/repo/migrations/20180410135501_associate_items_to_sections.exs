defmodule Spender.Repo.Migrations.AssociateItemsToSections do
  use Ecto.Migration

  def change do
    alter table(:wishlist_items) do
      add :log_section_id, references(:logsections)
    end

    create index(:wishlist_items, [:log_section_id])
  end
end
