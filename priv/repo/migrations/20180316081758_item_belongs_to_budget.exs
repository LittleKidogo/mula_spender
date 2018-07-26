defmodule Spender.Repo.Migrations.ItemBelongsToBudget do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :budget_id, references(:budgets, on_delete: :nothing, type: :binary_id)
    end
  end
end
