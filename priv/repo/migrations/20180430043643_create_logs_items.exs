defmodule Spender.Repo.Migrations.CreateLogsItems do
  use Ecto.Migration

  def change do
    create table(:logsections_items) do
      add :log_section_id, references(:logsections)
      add :wishlist_item_id, references(:wishlist_items)
    end
    
    create index(:logsections_items, [:log_section_id, :wishlist_item_id])
  end
end
