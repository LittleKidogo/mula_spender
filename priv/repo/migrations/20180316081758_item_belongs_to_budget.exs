defmodule Spender.Repo.Migrations.ItemBelongsToBudget do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :budget_id, references(:budgets)
    end
  end
end
