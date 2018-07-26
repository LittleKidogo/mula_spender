defmodule Spender.Repo.Migrations.LogsectionBelongsToBudget do
  use Ecto.Migration

  def change do
    alter table(:logsections) do
      add :budget_id, references(:budgets, on_delete: :nothing, type: :binary_id)
    end
  end
end
