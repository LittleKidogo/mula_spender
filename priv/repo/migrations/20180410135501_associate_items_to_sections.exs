defmodule Spender.Repo.Migrations.AssociateItemsToSections do
  use Ecto.Migration

  def change do
    alter table(:wishlist_items) do
      add :log_section_id, references(:logsections, on_delete: :nothing, type: :binary_id)
    end

    create index(:wishlist_items, [:log_section_id])
  end
end
